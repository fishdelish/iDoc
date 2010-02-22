class UsersController < ApplicationController

  before_filter :find_menu_items
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save_without_session_maintenance
      flash[:notice] = "Sign-up successful"
      redirect_to user_path(@user)
    else
      flash[:error] = "There were errors in the user data provided"
      render :action => :new
    end
    
  end

  def confirm
    @user = User.find_by_perishable_token(params[:activation_token])
    @user.activate!
    flash[:notice] = "Account activated"
    redirect_to new_user_session_url
  end

  def show
  end

end