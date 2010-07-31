require 'action_view/helpers/inherited_templates'
require 'inherited_templates_builder'

class ActionView::Base
  include InheritedTemplates
end

# class ActionView::Partials::PartialRenderer
#   include InheritedTemplates
# end
