class UsersController < ApplicationController
  
  respond_to :json
  
  def index
    @users = User.all
    respond_with @users, :api_template => :default
  end
  
  def show
    @user = User.find params[:id]
    respond_with @user, :api_template => :default
    # render :json => @user, :api_template => :v1_default #this works too
  end
end
