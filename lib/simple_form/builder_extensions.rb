module SimpleForm
  class ExtendedFormBuilder < FormBuilder
    
    def buttons(*args, &block)
      return InheritedTemplatesBuilder::Form::Buttons.render(self, block, *args)
    end
    
  end
end