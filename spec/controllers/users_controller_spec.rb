require 'spec_helper'

describe UsersController do
	integrate_views
  #Delete these examples and add some real ones
  it "should use UsersController" do
    controller.should be_an_instance_of(UsersController)
  end

	
	describe "GET 'new'" do
		it "should be successful" do
			get 'new'
			response.should be_success
		end
	
		it "should have the right title" do
			get 'new'
			response.should have_tag("title",/Sign up/)
		end
	end
	
	describe "GET 'show'" do		  
		before(:each) do
			@user = Factory(:user)
			#Arrange for User.find(params[:id] to find the right user
			User.stub!(:find, @user.id).and_return(@user)
		end
		
		it "should be successful" do
			get :show, :id => @user
			response.should be_success
		end
		
		it "should have the right title" do
			get :show, :id => @user
			response.should have_tag("title",/#{@user.name}/)
		end
		
		it "should include the user's name" do
			get :show, :id => @user
			response.should have_tag("h2",/#{@user.name}/)
		end
		
		it "should have a profile image" do
			get :show, :id => @user
			response.should have_tag("h2>img", :class => "gravatar")
		end
	end
	
	describe "Post 'create'" do
		describe "failure" do
			before(:each) do
				@attr = { :name => "", :email => "", :password => "", 
					:password_confirmation => ""}
				@user = Factory.build(:user, @attr)
				User.stub!(:new).and_return(@user)
				@user.should_receive(:save).and_return(false)
			end
			
			it "should have the right title" do
				post :create, :user => @attr
				response.should have_tag("title", /sign up/i)
			end
			
			it "should render the 'new' page" do
				post :create, :user => @attr
				response.should render_template('new')
			end
		end
		
		describe "success" do
			before(:each) do
				@attr = {:name => "New User", :email => "user@example.com",
					:password => "foobar", :password_confirmation => "foobar"}
				@user = Factory(:user, @attr)
				User.stub!(:new).and_return(@user)
				@user.should_receive(:save).and_return(true)
			end
			
			it "should redirect to the user show page" do
				post :create, :user => @attr
				response.should render_template(user_path(@user))
			end
			
			it "should have welcome message" do
				post :create, :user => @attr
				flash[:success].should =~ /welcome to the sample app/i
			end
			
			it "should sign the user in" do
				post :create, :user => @attr
				controller.should be_signed_in
			end
		end	
	end
end
