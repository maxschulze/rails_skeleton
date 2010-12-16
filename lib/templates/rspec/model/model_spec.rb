require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

Factory.define(:<%= file_name %>) do |f|
<% unless attributes.empty? -%>
<% for attribute in attributes -%>
  f.<%= attribute.name %> <%= attribute.default %>
<% end -%>
<% end -%>
end

describe <%= class_name %> do
  describe "Factory" do
    it "should be valid" do
      Factory(:<%= file_name %>).should be_valid
    end
  end
end
