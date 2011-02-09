class UsersController < ApplicationController
  
  respond_to :json, :xml
  
  def index
    @users = User.all
    respond_with @users, :api_template => :v1_default
  end
  
  def show
    @user = User.find params[:id]
    respond_with @user, :api_template => :v1_default
    # render :json => @user, :api_template => :v1_default #this works too
  end
end
