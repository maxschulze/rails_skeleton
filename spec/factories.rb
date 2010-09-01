#----------------------------------------------------------------------#
# sequences first
#----------------------------------------------------------------------#
Factory.sequence :email do |n|
  "person#{n}@example.com"
end

#----------------------------------------------------------------------#
# factories, which do not rely on other factories
#----------------------------------------------------------------------#
Factory.define :user do |f|
  f.email Factory.next :email
  f.password "secret"
  f.password_confirmation "secret"
end

#----------------------------------------------------------------------#
# factories with associations
#----------------------------------------------------------------------#

