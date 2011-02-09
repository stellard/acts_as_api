require 'spec_helper'

describe "respond_with integration" do
  
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
  
  describe "users" do
    before do
      User.acts_as_api
      User.api_accessible :default => [ :first_name, :last_name ]
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
  
  describe "tasks" do
    before do
      @destroy_deathstar = @luke.tasks.create({ :heading => "Destroy Deathstar", :description => "XWing, Shoot, BlowUp",  :time_spent => 30,  :done => true })
      @study_with_yoda   = @luke.tasks.create({ :heading => "Study with Yoda",   :description => "Jedi Stuff, ya know",   :time_spent => 60,  :done => true })
      @win_rebellion     = @luke.tasks.create({ :heading => "Win Rebellion",     :description => "no idea yet...",        :time_spent => 180, :done => false })
    end
    
    describe "index" do
      before do
        Task.acts_as_api
        Task.api_accessible :default => [ :heading, :done ]
        visit user_tasks_path(@luke, :format => :json)
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
          user["task"].should be_instance_of(Hash)
          user["task"]["heading"].should_not be_blank
          user["task"]["done"].should_not be_nil
          user["task"]["description"].should be_nil
        end
      end
    end
    
    describe "show" do
      before do
        visit user_task_path(@luke, @destroy_deathstar, :format => :json)
        @response = ActiveSupport::JSON.decode(last_response.body)
      end
      
      it "should be a hash" do
        @response.should be_instance_of(Hash)
        @response["task"].should be_instance_of(Hash)
      end
      
      it "should contain heading" do
        @response["task"]["heading"].should == 'Destroy Deathstar'
      end
      
      it "should contain done" do
        @response["task"]["done"].should == true
      end
      
      it "should not contain time_spent" do
         @response["task"]["time_spent"].should be_nil
      end
    end
  end

end
