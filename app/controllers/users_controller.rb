class UsersController < ApplicationController
 

  def index
	@users = User.find(:all)
  end
  
  def new
	@user = User.new
	@title = "Sign up"
  end
 
  def create
	@user = User.new(params[:user])
	if @user.save
		sign_in @user
		flash[:success] = "Welcome to the Sample App!"
		redirect_to @user
	else
		@title = "Sign up"
		render 'new'
	end
  end
  
  
  def show
	@user = User.find(params[:id])
	@pages = @user.pages.find(:all)	
  end
  
  def edit
	@user = User.find(params[:id])
  end
  
  def update
	@user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
	@user = User.find(params[:id])
	@user.destroy
	redirect_to :action => 'index'
  end
  
end
