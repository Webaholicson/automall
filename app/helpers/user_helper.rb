module UserHelper
  def hash_password(password)
    Digest::MD5.hexdigest(Base64.encode64(password))
  end

  def generate_approval_code
    (0...32).map { ((0..9).to_a+('a'..'z').to_a+('A'..'Z').to_a)[rand(61)] }.join
  end

  def is_user_logged_in?
    !session[:current_user_id].nil? or !cookies.signed[:remember_me].nil?
  end

  def get_flash_messages(type = nil)
    if !flash[:messages].nil?
      flash[:messages]
    end
  end
end
