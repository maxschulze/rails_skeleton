require 'action_view/helpers'
require 'action_view/paths'
require 'active_support/i18n'
require 'active_support/core_ext/enumerable'
require 'active_support/core_ext/object/blank'

module ActionView
  module Helpers
    module InheritedTemplates
      
      def view(object = nil, options = {}, &block)
        return InheritedTemplatesBuilder::Viewer.render(self, object, block, options).html_safe
      end
      
      def navigation(options = {}, &block)
        return InheritedTemplatesBuilder::Navigation.render(self, block, options)
      end
      
      def list(objects, options = {}, &block)
        return InheritedTemplatesBuilder::List.render(self, objects, block, options)
      end
      
      def sidebar(options = {}, &block)
        return InheritedTemplatesBuilder::Sidebar.render(self, block, options)
      end
      
      def element(options = {}, &block)
        return InheritedTemplatesBuilder::SidebarElement.render(self, block, options)
      end
      
      def page_title(title, options = {})
        return InheritedTemplatesBuilder::Title.render(self, title, options)
      end

      def slideshow(objects = [], options = {}, &block)
        return InheritedTemplatesBuilder::Slideshow.render(self, objects, block, options)
      end
  
    end
  end  
end

module ActionView
  class PathSet

    def find_with_exception_handling(path, prefix = nil, partial = false, details = {}, key = nil)
      begin
        find_without_exception_handling(path, prefix, partial, details, key)
      rescue ActionView::MissingTemplate => e
        # Do something with original_template_path, format, html_fallback
        
        case path
        when /index/
          original_template_path = "#{Rails.root}/app/views/defaults/index.html.erb"
        when /edit/
          original_template_path = "#{Rails.root}/app/views/defaults/edit.html.erb"
        when /new/
          original_template_path = "#{Rails.root}/app/views/defaults/new.html.erb"
        when /show/
          original_template_path = "#{Rails.root}/app/views/defaults/show.html.erb"
        else
          original_template_path = "defaults/object"
        end
        
        template = find_without_exception_handling(original_template_path, prefix, partial, details, key)
      end
    end
    
    alias_method_chain :find, :exception_handling

  end
end


