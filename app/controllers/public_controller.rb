class PublicController < ApplicationController
  skip_before_filter :login_required
  before_filter :instantiate_controller_and_action_names, :get_pages_for_tabs, :get_sub_tabs
 
  layout "public"
  
  def index 
    @page = Page.find_by_name(params[:name], :include => [:parent])
    if @page.nil?
      redirect_to(:action => "start")
    end
    
    DataFile.all.each do |img|
      
      if img.use == true 
        @image = img.photo.url 
      end
    end
    
  end
  
  def start
    
  end

  
  
end
