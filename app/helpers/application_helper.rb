module ApplicationHelper

  def encrypt(value)
  end

  def decrypt(value)
  end

  def get_form_value(key)
  end

  private

  def is_admin?
    !request.fullpath.match(/^\/admin/).nil?
  end
end
