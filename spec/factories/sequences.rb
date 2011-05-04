Factory.sequence :email do |n|
  "person#{n}@example.com"
end

Factory.sequence :login do |n|
  "person#{n}"
end