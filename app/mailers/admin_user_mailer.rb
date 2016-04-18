class AdminUserMailer < ApplicationMailer
  layout 'mailer'

  def welcome_email(user)
    @user = user
    @confirmation_url = url_for(host: 'localhost', controller: 'admin/index',
      action: 'change_password', only_path: false)
  end

  def reset_password(email, approval_code)
    @confirmation_url = url_for(port: 3000, host: 'localhost',
      controller: 'admin/index', action: 'change_password',
      only_path: false, approval_code: approval_code)

    mail(to: email, subject: 'Reset you password')
  end
end
