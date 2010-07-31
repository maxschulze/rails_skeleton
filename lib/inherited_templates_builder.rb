require 'blockenspiel'

module InheritedTemplatesBuilder
  
  class Base
    include Blockenspiel::DSL
    include ActionDispatch::Routing::UrlFor
    include ActionController::PolymorphicRoutes
    include Rails.application.routes.url_helpers
    default_url_options[:host] = Rails.env == 'production' ? 'beta.exploreb2b.com' : 'localhost:3000'
    
    attr_accessor :template, :object, :options, :html_array, :objects, :collection_html, :form, :method
    
    def initialize
      raise Exception, 'The #initialize method must be overwritten'
    end
    
    def self.logger
      @logger ||= Logger.new(File.open("#{Rails.root}/log/#{Rails.env}.log"))
    end
    
    def self.failed(msg, e)
      if Rails.env = "development"
        # die loud
        raise ArgumentError, "#{msg}\n\n---------- Error was\n\n #{e.inspect}\n\n ----------\n\n"
        return
      else
        # die silent
        logger.fatal "FATAL: /Inherited Templates/\n #{msg}\n\n---------- Error was #{e.inspect} ----------\n\n"
        return
      end
    end
    
    def include(*args)      
      options = args.extract_options!
      
      return template.render(options.merge(:partial => args.first)).html_safe
    end
    
    def t(*args)
      return I18n.t(*args).html_safe
    end
    
    def read_more(options = {})
      return self.template.link_to(
        I18n.t('Read more'), 
        options[:url], 
        :method => :get, 
        :class => "read-more"
      )
    end
    
    def strip_html(string)
      return string.gsub(/<\/?[^>]*>/,  "")
    end
    
    # awesome truncate
    def truncate(text, *args)
      options = args.extract_options!

      # support either old or the Rails 2.2 calling convention:
      unless args.empty?
        options[:length] = args[0] || 100
        options[:omission] = args[1] || "..."
      end
      options.reverse_merge!(:length => 100, :omission => "...")

      # support any of:
      #  * ruby 1.9 sane utf8 support
      #  * rails 2.1 workaround for crappy ruby 1.8 utf8 support
      #  * rails 2.2 workaround for crappy ruby 1.8 utf8 support
      # hooray!
      if text
        chars = if text.respond_to?(:mb_chars)
          text.mb_chars
        elsif RUBY_VERSION < '1.9'
          text.chars
        else
          text
        end

        omission = if options[:omission].respond_to?(:mb_chars)
          options[:omission].mb_chars
        elsif RUBY_VERSION < '1.9'
          options[:omission].chars
        else
          options[:omission]
        end

        l = options[:length] # - omission.length
        if chars.length > options[:length]
          result = (chars[/\A.{#{l}}\w*\;?/m][/.*[\w\;]/m]).to_s
          ((options[:avoid_orphans] && result =~ /\A(.*?)\n+\W*\w*\W*\Z/m) ? $1 : result) + options[:omission]
        else
          text
        end
      end
    end
  end
  
  class Extender
    include Blockenspiel::DSL
    
    attr_accessor :template
    
    def initialize(template)
      self.template = template
    end
    
    def view(object = nil, options = {}, &block)
      return InheritedTemplatesBuilder::Viewer.render(self.template, object, block, options).html_safe
    end
    
    def navigation(options = {}, &block)
      return InheritedTemplatesBuilder::Navigation.render(self.template, block, options)
    end
    
    def list(objects, options = {}, &block)
      return InheritedTemplatesBuilder::List.render(self.template, objects, block, options)
    end
    
    def sidebar(options = {}, &block)
      return InheritedTemplatesBuilder::Sidebar.render(self.template, block, options)
    end
    
    def element(options = {}, &block)
      return InheritedTemplatesBuilder::SidebarElement.render(self.template, block, options)
    end
    
    def page_title(title, options = {})
      return InheritedTemplatesBuilder::Title.render(self.template, title, options)
    end

    def slideshow(objects = [], options = {}, &block)
      return InheritedTemplatesBuilder::Slideshow.render(self.template, objects, block, options)
    end
  end  
  
  class Navigation < Base
    class << self
      def render(template, block, options = {})
        viewer = InheritedTemplatesBuilder::Navigation.new(template, options)
        Blockenspiel.invoke(block, viewer)

        return viewer.to_html
      end
    end
    
    def initialize(template, options = {})
      self.template = template
      self.options  = options
    end
    
    def search(query, url, options = {})
      options.symbolize_keys!
      
      return template.form_tag(url, :class => 'search-form') do
        template.content_tag('div', :class => 'search') do
          template.text_field_tag :query, query
        end + 
        template.content_tag('div', :class => 'search-buttons') do
          template.submit_tag I18n.t('Search')
        end
      end
    end
    
    def facebox(name, url, options = {})
      item(name, url, options.merge(:rel => 'facebox'))
      return nil      
    end
    
    def edit(object, url = nil, options = {})
      item('Edit', url || template.url_for(
                            :action => :edit, 
                            :controller => object.class.name.to_s.pluralize.downcase, 
                            :id => object.to_param
                          ), 
            options)
      return nil
    end
    
    def delete(object, url = nil, options = {})
      item('Delete', url || object, options.merge(:method => :delete, :confirm => I18n.t('Are you sure?')) )
      return nil
    end
    
    def message(receiver = nil, options = {})
      facebox('Send message', template.url_for(:controller => 'messages', :action => 'new', :receiver_user_id => receiver.nil? ? User.current.id : receiver.id, :format => :js))
      return nil
    end
    
    def connect(user)
      unless User.current.is_connected_with?(user)
        item('Add as contact', user_contacts_path(User.current, :establisher_contact_id => user.id), :method => :post)
      end
      
      return nil
    end
    
    def item(name, url, options = {})
      @items ||= []
      options.symbolize_keys!

      @items << template.content_tag('li', 
                  template.link_to(
                    options.has_key?(:t) ? I18n.t(name, options[:t]).html_safe : I18n.t(name).html_safe, url, options
                  ), 
                  :class => "#{'selected' if template.request.path == url}"
                ).html_safe
      return nil
    end

    def title(title, options = {})
      options.symbolize_keys!
      
      @title = template.content_tag('h1', I18n.t(title), options)

      return nil
    end

    def to_html
      unless @items.blank?
        template.content_tag('div', options) do
          "#{@title}" + 
          template.content_tag('ul', :class => 'clearfix') do
            @items.join() 
          end
        end
      end
    end
    
  end
  
  class Viewer < Base
    
    cattr_accessor :styles
    
    class << self
      def render(template, object, block, options = {})
        @klass = object.class.name.to_s
        
        if object.nil?
          renderer = template.view_context.instance_variable_get(:@renderer)
          template_options  = renderer.instance_variable_get(:@options)

          @klass = template_options[:collection].first.class.name.to_s unless template_options[:collection].blank?
        end

        # load default viewer if no custom viewer exists
        begin
          viewer = "#{@klass}Viewer".constantize.new(template, object, options)
        rescue Exception => e
          viewer = InheritedTemplatesBuilder::Viewer.new(template, object, options)
        end
        
        # include stylesheet
        self.styles ||= []
        
        unless self.styles.include?(@klass.downcase)
          if File.exists?("#{Rails.root}/public/stylesheets/#{@klass.downcase}.css")
            template.content_for(:head) do
              template.stylesheet_link_tag("#{@klass.downcase}")
            end
          end
          
          self.styles << @klass.downcase
        end

        return template.content_tag(
          options.delete(:tag) || 'div', 
          :class => [ 
            object.class.to_s.tableize.singularize.gsub('_', '-'),
            options.delete(:class),
            'clearfix'
          ].join(" ").strip
        ) do 
          Blockenspiel.invoke(block, viewer)
        end.html_safe
      end
    end
    
    def initialize(template, object, options = {})
      # on renderer I can call
      # - "@view"
      # - "@path"
      # - "@block"
      # - "@options"
      # - "@collection"
      # - "@object"
      # - "@locals"
      # - "@template"
      # - "@partial_names"
      
      #renderer        = template.view_context.instance_variable_get(:@renderer)
      #_options        = renderer.instance_variable_get(:@options)
      
      #puts _options[:locals].inspect.to_s
      
      #options         = options.merge(_options[:locals])
      self.object     = object
      self.options    = options
      self.template   = template
      self.html_array = []
      self.method     = nil
    end
    
    def delete(options = {})
      template.link_to(I18n.t('Delete'), options[:url] || object, :method => :delete, :confirm => I18n.t("Are you sure?"))
    end
    
    def default_render(method, *args)
      options     = args.extract_options!
      column      = find_attribute_column(method)
      column_type = column.try(:type)
      self.method = method
      
      # now build a div element with the correct class name and the object value
      # build different types for some default fields
      
      # titles will be linked
      if (method == 'title' || method == 'full_name') and (!options.has_key?(:linked) || options[:linked])
        link    = template.link_to(object.send(method), object, :title => object.to_s).html_safe
        element = wrap_tag(link, options)
      
      elsif column_type == :datetime || column_type == :timestamp
        element = wrap_tag(object.send(method).strftime('%d.%m.%Y %H:M'), options)
              
      elsif column_type == :date
        element = wrap_tag(object.send(method).strftime('%d.%m.%Y'), options)
        
      elsif method =~ /password/
        raise ArgumentError, 'You can not output the password'
        
      elsif method =~ /avatar/ || method =~ /image/ || method =~ /logo/
        url       = eval("object.#{method}.url(options[:size])")
        path      = "#{Rails.root}/public#{url}"
        
        #if File.exists?(path)
          image   = template.image_tag(url, :alt => object.to_s ).html_safe
        #else
        #  image   = ""
        #end
        
        link      = template.link_to(image, object, :title => object.to_s).html_safe
        element   = wrap_tag(link, options)
        
      elsif method =~ /file/
        link      = template.link_to(I18n.t("View {{file}}", :file => object.file_file_name), eval("object.#{method}.url()"), :title => object.to_s).html_safe
        element   = wrap_tag(link, options)
        
      elsif method =~ /email/  
        link      = template.link_to(t('E-Mail'), "mailto:#{object.send(method)}", :title => object.to_s).html_safe
        element   = wrap_tag(link, options)
        
      elsif method =~ /url/
        link      = template.link_to(object.send(method), "#{object.send(method)}", :title => object.to_s).html_safe
        element   = wrap_tag(link, options)
        
      # default logic simple div  
      else
        element = wrap_tag(object.send(method), options)
      end
      
      return element
    end
    
    def all
      out = ""
      object.content_columns.each do |column|
        out << default_render(column.to_s)
      end
      
      return out.html_safe
    end
    
    def wrap_tag(content, options = {})
      class_name  = "#{object.class.to_s.tableize.pluralize.gsub('_', '-').downcase}-#{method.to_s.downcase.gsub('_', '-')}"
      
      return template.content_tag(
        options[:tag] || 'div', 
        content, 
        :class => "#{class_name} #{options[:class]}".strip
      ).html_safe
    end
    
    # Finds the database column for the given attribute
    def find_attribute_column(attribute_name)
      object.column_for_attribute(attribute_name) if object.respond_to?(:column_for_attribute)
    end
    
    def custom_wrap_tag(tags, options = {})
      self.method = calling_method

      return wrap_tag(tags.join().html_safe, options)
    end
    
    def read_more(options = {})
      return template.link_to(
        I18n.t('Read more'), 
        options[:url] || object, 
        :method => :get, 
        :class => "#{object.class.name.to_s.tableize.gsub('_', '-').downcase}-read-more read-more".strip
      )
    end
    
    # This implements the universal logic
    def method_missing(method_name, *args)
      # We know that self is not responding so we try the object if it supports the method
      # If so we render it with the default renderer
      #puts method_name    
      #raise object.avatar.inspect if object.class == User
      
      if object.respond_to?(method_name)
        if method_name =~ /\?/
          return object.send(method_name)
        elsif (object.send(method_name).is_a?(Array) or object.send(method_name).is_a?(Object)) and not object.send(method_name).class == Paperclip::Attachment and not object.send(method_name).is_a?(String)
          puts method_name
          return object.send(method_name)
        else
          return default_render(method_name.to_s, *args)
        end
      elsif template.respond_to?(method_name)  
        return template.send(method_name)
      else  
        raise ArgumentError, 'Could not render ' + method_name.to_s
      end
    end
    
  end
  
  class Title < Base
    
    class << self
      def render(template, title, options = {})
        # build content for to yield in header
        template.content_for('title', I18n.t(title, options[:t]))
        return template.content_tag(options[:tag] || 'h2', I18n.t(title, options[:t]), :class => "page-title #{options[:class]}".strip).html_safe
      end
    end
    
  end
  
  class Slideshow < Base
    class << self
      def render(template, objects = [], block = nil, options = {})        
        #raise ArgumentError, 'You have to provide a collection for a slideshow to render' if object
    
        viewer = InheritedTemplatesBuilder::Slideshow.new(template, objects, options)
        
        return template.content_tag('div', :class => "slideshow-container #{options[:container_class]}") do
          template.content_tag('div', :class => "slideshow #{options[:class]}") do
            if block.present?
              Blockenspiel.invoke(block, viewer)
            else
              viewer.generate.html_safe
            end
          end
        end
      end
    end
    
    def initialize(template, objects = [], options = {})
      self.template         = template
      self.objects          = objects
      self.options          = options
      self.html_array       = []
      self.collection_html  = []
    end
    
    def generate
      out = ""
      
      self.objects.each do |slide|
        out << item(slide).html_safe
      end
      
      template.content_tag('ul', out.html_safe, :class => "slideshow-slides #{options[:slides_class]}")
      
      out << pagination.html_safe
      return out
    end
    
    def item(slide)
      return template.content_tag('li', :class => "slideshow-slide #{options[:slide_class]}") do
        template.image_tag( slide[:url], :alt => I18n.t(slide[:title]) ).html_safe + 
        "#{template.content_tag( 'div', I18n.t(slide[:title]), :class => "slideshow-slide-title" ) if slide[:title].present?}".html_safe + 
        "#{template.content_tag( 'div', I18n.t(slide[:text]), :class => "slideshow-slide-text" ) if slide[:text].present?}".html_safe
      end.html_safe
    end
    
    def pagination
      out = ""
      (0..(self.objects.length-1)).to_a.each do |count|
        out << pagination_item(count).html_safe
      end
      
      out = template.content_tag('ul', out.html_safe, :class => "slideshow-pagination #{options[:pagination_class]}").html_safe
      return out.html_safe
    end
    
    def pagination_item(count = 0)
      return template.content_tag('li', :class => "slideshow-pagination-item") do
        template.link_to('', "javascript:void(0);", :name => count).html_safe
      end.html_safe
    end
    
  end

  class Buttons < Base
    class << self
      def render(form, block = nil, *args)
        options = args.extract_options!
    
        viewer = InheritedTemplatesBuilder::Buttons.new(form, options)
      
        return form.template.content_tag('div', :class => 'form-buttons') do
          if block.present?
            Blockenspiel.invoke(block, viewer)
          else
            viewer.submit
          end
        end
      end
    end
  
    def initialize(form, options = {})
      self.form             = form
      self.template         = form.template
      self.object           = form.object
      self.options          = options
      self.html_array       = []
      
      @klass                = object.class.name.downcase.singularize
    end
    
    def submit(options = {})
      return template.submit_tag(
        I18n.t("#{@klass}.#{template.action_name}.submit"), 
        options.merge(:class => "submit #{@klass}-submit")
      ).html_safe
    end
    
    def abort(options = {})
      return template.submit_tag(
        I18n.t("#{@klass}.#{template.action_name}.abort"), 
        options.merge(
          :class => "abort #{@klass}-abort", 
          :onclick => "location.href = '#{options[:url] || '/'}'; return false;"
        )
      ).html_safe
    end
    
    def preview(options = {})        
      return template.submit_tag(
        I18n.t("#{@klass}.#{template.action_name}.preview"),
        options.merge(
          'data-url' => options.delete(:url) || eval("preview_#{@klass.pluralize}_path()"),
          :class => "preview #{@klass}-preview"
        )
      ).html_safe
    end
    
    def facebox_close
      return template.content_tag('input', '', 
        :type => 'reset', 
        :class => "facebox-close #{@klass}-facebox-close", 
        :onclick => '$.facebox.close(); return false;', 
        :value => I18n.t("Close")
      )
    end
  
  end

  class List < Base
    
    class << self
      def render(template, objects, block = nil, options = {})
        return if objects.blank? and not options[:blank_slate].present?
        
        viewer = InheritedTemplatesBuilder::List.new(template, objects, options)        
        
        if objects.blank? and options[:blank_slate].present?
          object_name = options.delete(:blank_slate)
        else
          object_name = objects.first.class
        end
        
        object_name = object_name.to_s.tableize.gsub('_', '-')
        
        return template.content_tag('div', :class => "#{object_name}-list #{options[:class]}".strip) do
          if block.present?
            Blockenspiel.invoke(block, viewer)
          else
            viewer.collection
          end
        end
      end
    end
    
    def initialize(template, objects, options = {})
      self.template         = template
      self.objects          = objects
      self.options          = options
      self.html_array       = []
      self.collection_html  = []
      
      @singular_klass       = objects.first.class.name.singularize.to_s
      @plural_klass         = @singular_klass.pluralize.to_s
      @use_custom           = false
      @default_partial      = "defaults/_object"
      @custom_partial       = "#{@plural_klass.tableize.downcase}/_#{@singular_klass.tableize.singularize.downcase}"
      
      # First check if there is a custom partial, if not we use the default renderer
      if File.exists?("#{Rails.root}/app/views/#{@custom_partial}.html.erb")
        @use_custom = true
      end
    end
    
    def title(title, options = {})
      return template.content_tag('h2', I18n.t(title, options.delete(:t)), options)
    end
    
    # renders the list
    def collection
      return if self.objects.blank?
      
      # now lets render the collection
      return template.content_tag(options[:tag] || 'ul') do
        template.render(
          :partial => @use_custom ? @custom_partial.gsub('/_', '/') : @default_partial, 
          :collection => objects, 
          :locals => options
        ).html_safe
      end
    end
    
    def read_more(options = {})
      template.link_to(
        I18n.t('Read more'), 
        options[:url] || eval("#{@plural_klass}_path"), 
        :method => :get, 
        :class => "#{objects.first.class.name.to_s.tableize.gsub('_', '-').downcase}-read-more read-more"
      )
    end
    
    # This implements the universal logic
    def method_missing(method_name, *args)
      raise ArgumentError, 'Could not render ' + method_name.to_s
    end
  end
  
  class SidebarElement < Base
    
    class << self
      def render(template, block, options = {})
        # load default viewer if no custom viewer exists
        viewer = InheritedTemplatesBuilder::SidebarElement.new(template, options)
        
        
        if options[:unless].present?
          u = options[:unless].is_a?(Proc) ? options[:unless].call : options[:unless]
          return unless !u
        end
        
        if options[:if].present?
          i = options[:if].is_a?(Proc) ? options[:if].call : options[:if]
          return if !i
        end
        
        return template.content_tag('div', :class => "sidebar-element #{options[:class]}") do
          Blockenspiel.invoke(block, viewer)
        end
      end
    end
    
    def initialize(template, options = {})
      self.html_array   = []
      self.options      = options
      self.template     = template
    end
    
    def title(title, options = {})
      template.content_tag('h2', I18n.t(title, options.delete(:t)), :class => "sidebar-element-title #{options[:class]}").html_safe
    end
    
    def view(object, options = {}, &block)
      InheritedTemplatesBuilder::Viewer.render(self.template, object, block, options)
    end
    
    def list(objects, options = {}, &block)
      InheritedTemplatesBuilder::List.render(self.template, objects, block, options)
    end
    
  end
  
  class Sidebar < Base
    
    class << self
      def render(template, block, options = {})
        # load default viewer if no custom viewer exists
        viewer = InheritedTemplatesBuilder::Sidebar.new(template, options)
        
        return template.content_tag('div', :class => "sidebar #{options[:class]}".strip ) do 
          if block.present?
            Blockenspiel.invoke(block, viewer)
          else
            begin
              template.render(:partial => 'sidebar', :locals => options).html_safe
            rescue Exception => e
              failed("Failed to render a local sidebar and no block has been provided.", e)
            end
          end
        end
      end
    end
    
    def initialize(template, options = {})
      self.template         = template
      self.options          = options
      self.html_array       = []
      self.collection_html  = []
    end
    
    # This implements the universal logic
    def method_missing(method_name, *args)
      # We know that self is not responding so we try the object if it supports the method
      # If so we render it with the default renderer
      if template.respond_to?(method_name)
        template.send(method_name.to_s, *args).html_safe
      else
        raise ArgumentError, 'Could not render ' + method_name.to_s
      end
    end
    
  end
  
end

module Kernel
  private
    def this_method
      caller[0] =~ /`([^']*)'/ and $1
    end
    
    def calling_method
      caller[1] =~ /`([^']*)'/ and $1
    end
end

