#----------------------------------------------------------------------#
# sequences first
#----------------------------------------------------------------------#
Factory.sequence :email do |n|
  "person#{n}@example.com"
end

Factory.sequence :login do |n|
  "person#{n}"
end

#----------------------------------------------------------------------#
# factories, which do not rely on other factories
#----------------------------------------------------------------------#
# Factory.define :user do |f|
#   f.email Factory.next :email
#   f.login Factory.next :login
#   f.first_name 'First'
#   f.last_name 'Last'
#   f.password "secret"
#   f.password_confirmation "secret"
# end

#----------------------------------------------------------------------#
# factories with associations
#----------------------------------------------------------------------#