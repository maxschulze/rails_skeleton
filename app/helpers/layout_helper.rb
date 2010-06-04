module LayoutHelper
  
  class SimpleLayoutBlock
    include Blockenspiel::DSL
    
    def initialize(template, options = {})
      @template = template
      options.symbolize_keys!
      @options = options
      @title = ""
      @items = []
    end
    
    def template
      @template
    end
    
    def options
      @options
    end
  end
  
  def navigation(options = {}, &block)
    viewer = LayoutHelper::Navigation.new(self, options)
    Blockenspiel.invoke(block, viewer)
    return viewer.to_html
  end
  
  class Navigation < SimpleLayoutBlock
    
    def item(name, url, options = {})
      @items ||= []
      options.symbolize_keys!
      
      @items << template.content_tag('li', template.link_to(name, url, options), 
                  :class => "#{'selected' if template.request.path == url}").html_safe
      return nil
    end
    
    def title(title, options = {})
      options.symbolize_keys!
      @title = template.content_tag('h1', I18n.t(title), options)
      
      return nil
    end
    
    def to_html
      template.content_tag('nav', options) do
        @title + 
        template.content_tag('ul') do
          @items.join()
        end
      end
    end
    
  end
  
end