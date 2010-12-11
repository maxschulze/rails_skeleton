# load factory_girl specifics
begin
  require 'factory_girl'
  require 'factory_girl/step_definitions'
rescue LoadError => ignore_if_you_maybe_dont_use_factory
end
