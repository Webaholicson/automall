module Admin
  module SessionHelper
    def is_user_logged_in?
      !session[:admin]['current_user_id'].nil?
    end
  end
end
