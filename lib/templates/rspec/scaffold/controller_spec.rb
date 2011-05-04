require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe <%= controller_class_name %>Controller do
  include Devise::TestHelpers

  describe "with login" do
    before :each do
      @<%= file_name %> = Factory(:<%= file_name %>)
      sign_in @user = Factory(:user)
    end

<% unless options[:singleton] -%>
    describe "GET index" do
      it "assigns all <%= table_name.pluralize %> as @<%= table_name.pluralize %>" do
        <%= class_name %>.stubs(:find).returns([@<%= file_name %>])
        get :index
        assigns(:<%= table_name %>).should eq([@<%= file_name %>])
      end
    end
<% end -%>

    describe "GET show" do
      it "assigns the requested <%= file_name %> as @<%= file_name %>" do
        get :show, :id => @<%= file_name %>
        assigns(:<%= file_name %>).should == @<%= file_name %>
      end
    end

    describe "GET new" do
      it "assigns a new <%= file_name %> as @<%= file_name %>" do
        get :new
        assigns(:<%= file_name %>).should be_new_record
      end
    end

    describe "GET edit" do
      it "assigns the requested <%= file_name %> as @<%= file_name %>" do
        get :edit, :id => @<%= file_name %>
        assigns(:<%= file_name %>).should == @<%= file_name %>
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "assigns a newly created <%= file_name %> as @<%= file_name %>" do
          post :create, :<%= file_name %> => Factory.attributes_for(:<%= file_name %>)
          assigns(:<%= file_name %>).should_not be_new_record
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved <%= file_name %> as @<%= file_name %>" do
          <%= class_name %>.any_instance.stubs(:save).returns(false)
          post :create, :<%= file_name %> => Factory.attributes_for(:<%= file_name %>)
          assigns(:<%= file_name %>).should be_new_record
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested <%= file_name %>" do
          <%= class_name %>.stubs(:find).with("37").returns(@<%= file_name %>)
          @<%= file_name %>.expects(:update_attributes).with(<%= params %>)
          put :update, :id => "37", :<%= file_name %> => <%= params %>
        end

        it "assigns the requested <%= file_name %> as @<%= file_name %>" do
          <%= class_name %>.any_instance.stubs(:valid).returns(true)
          put :update, :id => @<%= file_name %>
          assigns(:<%= file_name %>).should == @<%= file_name %>
        end
      end

      describe "with invalid params" do
        it "assigns the <%= file_name %> as @<%= file_name %>" do
          <%= class_name %>.any_instance.stubs(:valid).returns(false)
          put :update, :id => @<%= file_name %>
          assigns(:<%= file_name %>).should == @<%= file_name %>
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested <%= file_name %>" do
        delete :destroy, :id => @<%= file_name %>
        <%= class_name %>.find_by_id(@<%= file_name %>).should be_nil
      end
    end
  end

  describe "without login" do
    before :each do
      @<%= file_name %> = Factory(:<%= file_name %>)
    end

<% unless options[:singleton] -%>
    describe "GET index" do
      it "assigns all <%= table_name.pluralize %> as @<%= table_name.pluralize %>" do
        <%= class_name %>.stubs(:find).returns([@<%= file_name %>])
        get :index
        assigns(:<%= table_name %>).should eq([@<%= file_name %>])
      end
    end
<% end -%>

    describe "GET show" do
      it "assigns the requested <%= file_name %> as @<%= file_name %>" do
        get :show, :id => @<%= file_name %>
        assigns(:<%= file_name %>).should == @<%= file_name %>
      end
    end

    describe "GET new" do
      it "assigns a new <%= file_name %> as @<%= file_name %>" do
        get :new
        assigns(:<%= file_name %>).should be_new_record
      end
    end

    describe "GET edit" do
      it "assigns the requested <%= file_name %> as @<%= file_name %>" do
        get :edit, :id => @<%= file_name %>
        assigns(:<%= file_name %>).should == @<%= file_name %>
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "assigns a newly created <%= file_name %> as @<%= file_name %>" do
          post :create, :<%= file_name %> => Factory.attributes_for(:<%= file_name %>)
          assigns(:<%= file_name %>).should_not be_new_record
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved <%= file_name %> as @<%= file_name %>" do
          <%= class_name %>.any_instance.stubs(:save).returns(false)
          post :create, :<%= file_name %> => Factory.attributes_for(:<%= file_name %>)
          assigns(:<%= file_name %>).should be_new_record
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested <%= file_name %>" do
          <%= class_name %>.stubs(:find).with("37").returns(@<%= file_name %>)
          @<%= file_name %>.expects(:update_attributes).with(<%= params %>)
          put :update, :id => "37", :<%= file_name %> => <%= params %>
        end

        it "assigns the requested <%= file_name %> as @<%= file_name %>" do
          <%= class_name %>.any_instance.stubs(:valid).returns(true)
          put :update, :id => @<%= file_name %>
          assigns(:<%= file_name %>).should == @<%= file_name %>
        end
      end

      describe "with invalid params" do
        it "assigns the <%= file_name %> as @<%= file_name %>" do
          <%= class_name %>.any_instance.stubs(:valid).returns(false)
          put :update, :id => @<%= file_name %>
          assigns(:<%= file_name %>).should == @<%= file_name %>
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested <%= file_name %>" do
        delete :destroy, :id => @<%= file_name %>
        <%= class_name %>.find_by_id(@<%= file_name %>).should be_nil
      end
    end
  end
end
