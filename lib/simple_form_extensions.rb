require 'inherited_templates_builder'

class SimpleForm::FormBuilder
  include SimpleForm::FormBuilder::Extensions
end

class SimpleForm::FormBuilder::Extensions
  
  def buttons(*args, &block)
    return InheritedTemplatesBuilder::Form::Buttons.render(self, block, *args)
  end
  
end