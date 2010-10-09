# spec/support/factory_helper.rb
module FactoryHelper

  def self.included(base)
    base.send(:include, FactoryHelper::InstanceMethods)
  end

  module InstanceMethods
    # Extracts a klass name and the attribute name out of a string
    # like this: find_or_create_factory_KLASS_NAME_by_ATTRIBUTE
    # It returns the Class of KLASS_NAME if defined and the ATTRIBUTE
    # In case KLASS_NAME is no valid constant, the String "KLASS_NAME"
    # is returned.
    # ==== Parameters
    # name of a method
    def extract_class_and_attributes_from name
      regexp = /^find_or_create_factory_(.+?)_by_(.+?)$/
      attribute = name.to_s
      return name unless attribute =~ regexp

      klass_name = $1.capitalize
      attribute_name = $2

      if Kernel.const_defined?(klass_name)
        [Kernel.const_get(klass_name), attribute_name]
      else
        [klass_name, attribute_name]
      end
    end
    # intercepts methods which look like
    # /^find_or_create_factory_(.+?)_by_(.+?)$/ as where the first
    # braces match the factory name and the second braces match the
    # primary attribute you're searching for.
    # ==== Parameters
    # name of the method
    # args for the method
    def method_missing(name, *args)
      klass, attribute = extract_class_and_attributes_from name
      if klass.class == String || attribute.blank?
        super(name, *args)
      else
        find_or_create_factory(klass, attribute, *args)
      end
    end

    private

    # finds an object or creates one, where the first attribute must
    # be the field you're searching for (so this must be unique).
    #
    # ==== Parameters
    # klass_name: the name of your model
    # attributes: e.g. :title => "foo", :bar => "bar"
    def find_or_create_factory klass, attribute, *attributes
      attribute = attribute.to_sym
      obj = klass.send(:where, attribute => attributes[0][attribute]).first
      obj || Factory(klass.to_s.downcase.to_sym, *attributes)
    end
  end
end
