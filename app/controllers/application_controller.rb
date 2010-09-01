# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
  
class ApplicationController < ActionController::Base
  #require 'rss'
  
  include SimpleCaptcha::ControllerHelpers
  
  helper :all # include all helpers, all the time
  include AuthenticatedSystem
  before_filter :login_required
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '5ff9bae5c73b0c12f85fb9d0afda53fa'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
 
 def create
    @users = User.find(:all)
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button.Uncomment if you understand the tradeoffs.
      # reset session
     
      redirect_to(users_path)
      flash[:notice] = "Ny bruker lagt til!"
    else
      flash[:error]  = "Hei. Vi kunne ikke lage kontoen. Det er viktig at du skriver riktig navn og epost og har et brukernavn mellom 3 og 40 karakterer."
      render :action => 'index'
    end
  end
  
 
  def instantiate_controller_and_action_names
     @current_action = action_name
     @current_controller = controller_name
  end 
  
  def get_pages_for_tabs
    @tabs = Page.find_main 
 end
 
 def get_sub_tabs
    @subtabs = Page.find_subpages
 end
end
