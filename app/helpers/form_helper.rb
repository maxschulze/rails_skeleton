module FormHelper
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    
    fields = f.simple_fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      content_tag('div', :class => "fields #{association}") do
        render("#{f.object.class.to_s.pluralize.downcase}/form/#{association.to_s.singularize}_fields", :f => builder) + 
        link_to_remove_fields('Remove', builder)
      end
    end
    
    content_tag('div', :class => "fields #{association}") do
      raw("<script type=\"text/javascript\">
        $(document).ready(function() {  
          $('div.#{association.to_s.pluralize} a').click();
          $('div.#{association.to_s.pluralize} a.remove').remove();
        });
      </script>") +
      link_to_function(t(name), "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", :class => 'add')
    end
  end
  
  def link_to_remove_fields(name, f)
    return f.hidden_field(:_destroy) + link_to_function(t(name), "remove_fields(this)", :class => 'remove')
  end
  
end