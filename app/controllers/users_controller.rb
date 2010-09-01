class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  if User.all.length < 1
  skip_before_filter :login_required
  else
    before_filter :login_required
  end
  def index
    @users = User.find(:all)
    if request.get? && !params[:id].blank?
      @user = User.find(params[:id])
      elsif request.get? && params[:id].blank?
      @user = User.new
      elsif request.post? && !params[:id].blank?
      @user = User.find(params[:id])
      if params[:commit] == "oppdater"
        
     
        respond_to do |format|
          
          if @user.update_attributes(params[:user])
            flash[:notice] = 'Brukeren ble oppdatert'
            format.html { redirect_to(:action => "index") }
            format.xml  { head :ok }
          else
            format.html { render :action => "index" }
            format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
          end
      end
      end
    end
  end
  end
  # render new.rhtml
  def new
    @user = User.new
  end
  def edit
    @user = User.find(params[:id])
    render( :view => "index")
  end
 
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
  
  
  def destroy
    @user = User.find(params[:id])
    @users = User.all
    if @users.lenght > 1
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_path) }
      format.xml  { head :ok }
    end
  else
  flash[:notice] = "Sletter du den siste brukeren kommer du ikke inn igjen!!"
      render :action => 'index'
  end
end
