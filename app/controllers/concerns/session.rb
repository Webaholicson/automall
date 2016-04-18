module Session
  extend ActiveSupport::Concern

  included do
    before_action :setup_admin_session
  end

  protected

  def get_session
    session[:admin]
  end

  def session_set(key, value)
    get_session()[key] = value
  end

  def session_get(key)
    get_session()[key]
  end

  private

  def setup_admin_session
    if session[:admin].nil?
      session[:admin] = Hash.new
    end
    session[:admin]
  end
end
