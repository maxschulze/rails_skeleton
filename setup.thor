class Setup < Thor

  desc "config [NAME]", "copy configuration files"
  method_options :force => :boolean
  def config(name = "*")
    Dir["config/examples/#{name}"].each do |source|
      destination = "config/#{File.basename(source)}"
      FileUtils.rm(destination) if options[:force]
      if File.exist?(destination)
        puts "Skipping #{destination} because it already exists"
      else
        puts "Generating #{destination}"
        FileUtils.cp(source,destination)
      end
    end
  end

  desc "rename TO [--from FROM]", "Renames your app"
  method_options :from => "RenameMePlz"
  def rename(to)
    from = options[:from]
    (Dir["config/**/*.rb"] + ["Rakefile","config.ru"]).each do |source|
      # in file editing like this:
      # %x{ruby -pi -e "gsub(/#{from}/, '#{to}')" #{source}}
      File.open(source, 'r+') do |f|
        out = ""
        f.each do |line|
          out << line.gsub(/#{from}/) {to} # store each line
        end
        f.pos = 0 # reset the position
        f.print out #print file
        f.truncate(f.pos) # set file length
      end # file closes automagically
    end
  end

  desc "git APP_NAME", "sets up the git repository"
  def git(appname)
    setup_skeleton_branch
    %x{git commit -vm "renamed app"}
    repo = ask("Which repository (leave empty for default)? :")
    if repo == ""
      add_origin("#{appname}")
    else
      add_origin(repo,false)
    end
    push_to_master = ask("push to master? (no/yes)")
    %x{git push origin master} if push_to_master == "yes"
  end

  desc "app APP_NAME", "renames your app and creates a .rvmrc file for it"
  def app(app_name = "foo_bar")
    # require File.expand_path("config/environment.rb")
    invoke :rename, [camel_case(app_name)]
    invoke :config, ["*"]
    puts "Initializing submodules"
    %x{git submodule init}
    %x{git submodule update}
    puts "Creating databases"
    %x{rake db:migrate}
    %x{rake db:test:clone}
    %x{rake db:seed}
    puts "Testing this app template"
    %x{rake}
    invoke :git, [app_name]
  end

  private

  def setup_skeleton_branch
    %x{git remote rename origin skeleton}
    %x{git branch "skeleton"}
    %x{git config branch.skeleton.remote skeleton}
    %x{git config branch.skeleton.merge refs/heads/master}
  end

  def camel_case str
    str.split(/_/).map(&:capitalize).join
  end

  def add_origin(name, default = true)
    %x{git remote add origin #{name}}
    if default
      puts <<-GIT
#{'*'*70}
# gitosis-admin/gitosis.conf
[group urbanvention]
writable = #{name}
#{'*'*70}
GIT
    end
  end
end
