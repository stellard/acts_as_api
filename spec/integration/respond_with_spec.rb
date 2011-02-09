require 'spec_helper'

describe "rails integration" do
  
  it "should be true" do
    assert_kind_of Dummy::Application, Rails.application
  end
  
  before do
    @luke = User.create({ :first_name => 'Luke',      :last_name => 'Skywalker', :age => 25, :active => true  })
    @han  = User.create({ :first_name => 'Han',       :last_name => 'Solo',      :age => 35, :active => true  })
    @leia = User.create({ :first_name => 'Princess',  :last_name => 'Leia',      :age => 25, :active => false })
  end
  
  after(:each) do
    User.delete_all
    Task.delete_all
  end
  
  describe "respond_with" do
    before do
      User.acts_as_api
      User.api_accessible :v1_default => [ :first_name, :last_name ]
    end
    
    describe "index" do
      before do
        visit users_path(:format => :json)
        @response = ActiveSupport::JSON.decode(last_response.body)
      end
      
      it "should return an array" do
        @response.should be_instance_of(Array)
      end

      it "should contain all the records" do
        @response.length.should == 3
      end
      
      it "each record should be correct" do
        @response.each do |user|
          user["user"].should be_instance_of(Hash)
          user["user"]["first_name"].should_not be_blank
          user["user"]["last_name"].should_not be_blank
          user["user"]["age"].should be_nil
        end
      end
    end
    
    describe "show" do
      before do
        visit user_path(@luke, :format => :json)
        @response = ActiveSupport::JSON.decode(last_response.body)
      end
      
      it "should be a hash" do
        @response.should be_instance_of(Hash)
        @response["user"].should be_instance_of(Hash)
      end
      
      it "should contain first_name" do
        @response["user"]["first_name"].should == 'Luke'
      end
      
      it "should contain last_name" do
        @response["user"]["last_name"].should == 'Skywalker'
      end
      
      it "should not contain age" do
         @response["user"]["age"].should be_nil
      end
    end
  
  end

end
