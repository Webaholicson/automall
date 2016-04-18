class AccountController < IndexController
  include UserHelper

  before_action :setup_messages, :require_login

  skip_before_action :require_login, only:
    [:login, :register, :login_post, :register_post]

  skip_before_action :setup_messages, only:
    [:login, :dashborad, :register, :edit]

  layout '1-column'

  def login
    if session[:current_user_id]
      redirect_to action: 'dashboard'
    end
  end

  def dashboard
    @user = User.find_by(id: get_current_user_id)
    render template: 'account/dashboard', layout: '2-columns-left'
  end

  def edit
    @user = User.find_by(id: get_current_user_id)
    render template: 'account/edit', layout: '2-columns-left'
  end

  def listing
    @user = User.find_by(id: get_current_user_id)
    render template: 'account/listing', layout: '2-columns-left'
  end

  def saved_listings
    @user = User.find_by(id: get_current_user_id)
    render template: 'account/listing', layout: '2-columns-left'
  end

  def register
  end

  def login_post
    begin
      create_user_session params
    rescue Exception => e
      flash[:messages][:alert] = e.message
      redirect_to action: 'login' and return
    end
    redirect_to action: 'dashboard'
  end

  def logout
    if get_current_user_id
      session[:current_user_id] = nil
      cookies.delete(:remember_me)
    end

    flash[:messages][:success] = I18n.t :user_success_logout
    redirect_to root_url
  end

  def register_post
    begin
      params[:password] = hash_password(params[:password]) if params[:password]
      user = User.new
      user.register params
      flash[:messages][:success] = I18n.t :user_was_registered
      redirect_to action: 'login'
    rescue Exception => e
      flash[:messages][:alert] = e.message
      flash[:input] = params
      redirect_to action: 'register'
    end
  end

  def save
    begin
      user = User.find_by(id: get_current_user_id)

      if !params[:user][:password].empty?
        user.password = hash_password(params[:user][:password])
      end

      if (user.update!(user_params))
        flash[:messages][:success] = I18n.t :user_was_saved
        redirect_to :back and return;
      else
        raise I18n.t :user_was_not_saved
      end
    rescue Exception => e
      flash[:messages][:alert] = e.message
    end

    redirect_to action: 'edit' and return
  end

  private

  def create_user_session(params)
    user = User.find_by(
      email: params[:email],
      password: hash_password(params[:password])
    )

    if user
      session[:current_user_id] = user.id
      if params[:remember_me]
        cookies.signed[:remember_me] =
          { value: user.id, expires: 1.year.from_now }
      end
    else
      raise I18n.t :invalid_user
    end
  end

  def require_login
    unless get_current_user_id
      flash[:messages][:alert] = I18n.t :must_login
      redirect_to action: 'login'
    end

    if session[:current_user_id].nil? and cookies.signed[:remember_me]
      session[:current_user_id] = cookies.signed[:remember_me]
    end
  end

  def setup_messages
    if flash[:messages].nil?
      flash[:messages] = Hash.new
    end
  end

  def get_current_user_id
    id = nil
    if session[:current_user_id]
      return session[:current_user_id]
    elsif cookies.signed[:remember_me]
      return cookies.signed[:remember_me]
    else
      return id
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
