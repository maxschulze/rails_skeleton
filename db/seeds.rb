# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
I18nDatabase::Locale.create(:code => 'en', :name => 'English')
I18nDatabase::Locale.create(:code => 'de', :name => 'German')
I18nDatabase::Locale.create(:code => 'es', :name => 'Spanish')