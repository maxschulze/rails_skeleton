module PersonsHelper
  
  def person(person, &block)
    if block_given?
      viewer = PersonsHelper::Viewer.new(person, self)
      Blockenspiel.invoke(block, viewer)
      return viewer.to_html
    else
      link_to(person.full_name, person)
    end
  end
  
  class Viewer
    include Blockenspiel::DSL
    
    def initialize(person, template)
      @@person    = person
      @avatar     = @name = ""
      @template   = template
    end
    
    def avatar(options = {})
      options.symbolize_keys!
      
      @avatar = @template.link_to(
        @template.image_tag(
          @@person.avatar.url(options[:size] || nil), 
          :alt => @@person.full_name
        ), 
        @@person
      )
      return nil
    end
    
    def name(options = {})
      options.symbolize_keys!
      
      @name = @template.link_to(@@person.full_name, @@person, :class => 'name')
      return nil
    end
    
    def to_html
      return @template.content_tag('div', :class => 'person') do
        @template.content_tag('details') do
          @template.content_tag('summary', "Details about #{@@person.full_name}") + 
          @name + 
          @avatar + 
          @template.content_tag('div', '', :class => 'clear')
        end
      end
    end
  end
  
  def person_location_values
    ['Work', 'Home']
  end
  
  def person_web_presences_network_values
    ['Facebook']
  end
  
  def person_instant_messenger_protocol_values
    ['Skype']
  end
  
  def person_relationship_status_values
    ['Single']
  end
end
