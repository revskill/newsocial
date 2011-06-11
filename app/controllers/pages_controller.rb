class PagesController < ApplicationController
    
  before_filter :get_user, :except => :index
  
  def index
	@pages = Page.all
	if signed_in? 		
		@user = current_user						
	end
	
  end

  def show    
	
	@page = Page.find(params[:id])
	
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
		
  end

  def new
	@page = @user.pages.build
	respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page }
    end
  end

  def create
	
	@page = @user.pages.build(params[:page])
	
	respond_to do |format|
		if @page.save		
			format.html { redirect_to([@user,@page], :notice => 'Papge was successfully updated.') }	
			format.xml  { head :ok }	
		else
			@title = "New Page"
			format.html { render :action => "new" }
			format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
		end
	end
  end

  def edit
	@page = @user.pages.find(params[:id])
  end

  def update
	@page = @user.pages.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to([@user,@page], :notice => 'Papge was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
	@page = @user.pages.find(params[:id])
	@page.destroy
	redirect_to @user
  end
  private
  def get_user
	@user = current_user
  end

end
