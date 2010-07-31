require 'test_helper'

class WrapperTest < ActionView::TestCase
  def with_error_for(object, attribute_name, options={}, &block)
    concat(simple_form_for(object) do |f|
      f.options = options
      f.input attribute_name
    end)
  end

  def with_form_for(object, *args, &block)
    concat(simple_form_for(object) do |f|
      concat f.input(*args, &block)
    end)
  end

  test 'wrapper should not have error class for attribute without errors' do
    with_error_for @user, :active
    assert_no_select 'div.fieldWithErrors'
  end

  test 'wrapper should not have error class when object is not present' do
    with_error_for :project, :name
    assert_no_select 'div.fieldWithErrors'
  end

  test 'wrapper should add error class for attribute with errors' do
    with_error_for @user, :name
    assert_select 'div.fieldWithErrors'
  end

  test 'wrapper should add chosen error class for attribute with errors' do
    swap SimpleForm, :wrapper_error_class => "omgError" do
      with_error_for @user, :name
      assert_select 'div.omgError'
    end
  end

  test 'wrapper should add chosen wrapper class' do
    swap SimpleForm, :wrapper_class => "wrapper" do
      with_form_for @user, :active
      assert_select 'div.wrapper'
      assert_no_select 'div.input'

      with_form_for @user, :name
      assert_select 'div.wrapper'
      assert_no_select 'div.input'

      with_form_for :project, :name
      assert_select 'div.wrapper'
      assert_no_select 'div.input'
    end
  end
end
