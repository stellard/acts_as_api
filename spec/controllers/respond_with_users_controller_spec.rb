require File.dirname(__FILE__) + '/../spec_helper.rb'

describe RespondWithUsersController do
	before(:each) do
    @luke = User.create({ :first_name => 'Luke',      :last_name => 'Skywalker', :age => 25, :active => true  })
    @han  = User.create({ :first_name => 'Han',       :last_name => 'Solo',      :age => 35, :active => true  })
    @leia = User.create({ :first_name => 'Princess',  :last_name => 'Leia',      :age => 25, :active => false })
  end

  after(:each) do
    User.delete_all
  end

  # describe 'xml responses' do
  # 
  #   describe 'get all users' do
  # 
  #     before(:each) do
  #       get :index, :format => 'xml', :api_template => :name_only
  #     end
  # 
  #     it "should have a root node named users" do
  #       response_body.should have_selector("users")
  #     end
  # 
  #     it "should contain all users" do
  #       response_body.should have_selector("users > user") do |users|
  #         users.size.should eql(3)
  #       end
  #     end
  # 
  #     it "should contain the specified attributes" do
  #       response_body.should have_selector("users > user > first-name")
  #       response_body.should have_selector("users > user > last-name")
  #     end
  # 
  # 			it "should not contain the unspecified attributes" do
  # 				response_body.should_not have_selector("users > user > age")
  # 				response_body.should_not have_selector("users > user > active")
  # 			end
  # 
  #   end
  # 
  #   describe 'get a single user' do
  # 
  #     before(:each) do
  #       get :show, :format => 'xml', :api_template => :name_only, :id => @luke.id
  #     end
  # 
  #     it "should have a root node named user" do
  #       response_body.should have_selector("user")
  #     end
  # 
  #     it "should contain the specified attributes" do
  #       response_body.should have_selector("user > first-name")
  #       response_body.should have_selector("user > last-name")
  #     end
  # 
  #  			it "should not contain the unspecified attributes" do
  #  				response_body.should_not have_selector("user > age")
  #  				response_body.should_not have_selector("user > active")
  #  			end
  # 
  #   end
  # 
  # end
	
  describe 'json responses' do

    describe 'get all users' do

      before(:each) do
        get :index, :format => 'json', :api_template => :name_only
      end

      it "should contain all users" do
        response_body_json.should be_a(Array)
      end

      it "should contain the specified attributes" do
        response_body_json.first["user"].should have_key("first_name")
        response_body_json.first["user"].should have_key("last_name")
      end

			it "should not contain the unspecified attributes" do
			  response_body_json.first["user"].should_not have_key("age")
        response_body_json.first["user"].should_not have_key("active")
			end

      it "should contain the specified values" do
        response_body_json.first["user"]["first_name"].should eql("Luke")
        response_body_json.first["user"]["last_name"].should eql("Skywalker")
      end

    end

    describe 'get a single user' do

      before(:each) do
        get :show, :format => 'json', :api_template => :name_only, :id => @luke.id
      end

      it "should have a root node named user" do
        response_body_json.should have_key("user")
      end

      it "should contain the specified attributes" do
        response_body_json["user"].should have_key("first_name")
        response_body_json["user"].should have_key("last_name")
      end
			
			it "should not contain the unspecified attributes" do
			  response_body_json["user"].should_not have_key("age")
        response_body_json["user"].should_not have_key("active")
			end

      it "should contain the specified values" do
        response_body_json["user"]["first_name"].should eql("Luke")
        response_body_json["user"]["last_name"].should eql("Skywalker")
      end

    end

  end
end
