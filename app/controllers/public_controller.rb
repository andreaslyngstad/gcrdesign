class PublicController < ApplicationController
  skip_before_filter :login_required
  before_filter :instantiate_controller_and_action_names, :get_pages_for_tabs, :get_sub_tabs
 
  layout "public"
  
  def index 
    @page = Page.find_by_name(params[:name])
    @pages = Page.roots(nil)
    if @page.nil?
      redirect_to(:action => "start")
    end  
  end
  
  def start
    
  end

  
  
end
