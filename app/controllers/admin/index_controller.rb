module Admin
  class IndexController < AdminController

    skip_before_action :is_logged_in?, only: [
      :logout,
      :login,
      :login_post,
      :forgot_password,
      :forgot_password_post,
      :change_password,
      :change_password_post
    ]

    def dashboard
      if !is_user_logged_in?
        redirect_to action: 'login' and return
      end
    end

    def login_post
      begin
        authenticate_user params
        redirect_to action: 'dashboard' and return
      rescue Exception => e
        set_flash_message 'alert', e.message
      end
      redirect_to action: 'login' and return
    end

    def logout
      session_set 'current_user_id', nil
      redirect_to action: 'login' and return
    end

    def forgot_password

    end

    def forgot_password_post
      begin
        if !params[:email].empty?
          approval_code = generate_approval_code
          user = AdminUser.find_by(email: params[:email])
          if user
            user.approval_code = approval_code
            user.save
          end

          AdminUserMailer.reset_password(params[:email], approval_code).deliver_later
          set_flash_message 'success', I18n.t(:password_reset_email_sent)
          redirect_to action: 'login' and return
        end

        raise I18n.t :invalid_email
      rescue Exception => e
        set_flash_message 'alert', e.message
      end

      redirect_to action: 'forgot_password' and return
    end

    def change_password
      begin
        validate_approval_code params
        user = AdminUser.find_by(approval_code: params[:approval_code])
        raise I18n.t :invalid_approval_code if !user
        @approval_code = params[:approval_code]
      rescue Exception => e
        set_flash_message 'alert', e.message
        redirect_to action: 'login' and return
      end
    end

    def change_password_post
      begin
        validate_password_update params
        validate_approval_code params
        user = AdminUser.find_by(approval_code: params[:approval_code])
        raise I18n.t :invalid_approval_code if !user
        user.update!(
          password: hash_password(params[:password]),
          password_confirmation: hash_password(params[:password_confirmation])
        )
        set_flash_message 'success', I18n.t(:password_was_changed)
      rescue Exception => e
          set_flash_message 'alert', e.message
          redirect_to action: 'change_password',
            approval_code: params[:approval_code] and return
      end

      redirect_to action: 'login' and return
    end

    private

    def validate_approval_code(params)
      if params[:approval_code].empty?
        raise I18n.t :invalid_approval_code
      end
    end

    def validate_password_update(params)
      if params[:password].empty? or params[:password_confirmation].empty?
        raise I18n.t :passwords_dont_match
      end
    end

    def authenticate_user(params)
      user = AdminUser.find_by(
        username: params[:username],
        password: hash_password(params[:password]),
        active: true
      )
      if user
        user.set_already_confirmed
        session_set 'current_user_id', user.id
      else
        raise I18n.t :invalid_admin_user
      end
    end
  end
end
