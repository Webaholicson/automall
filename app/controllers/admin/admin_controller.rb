module Admin
  class AdminController < ApplicationController
    include UserHelper
    include ApplicationHelper
    include Session
    include Flash

    layout :set_layout

    before_action :set_body_class, :is_logged_in?

    private

    def set_body_class
      @border_class = ''

      if is_user_logged_in?
        @border_class = ' authenticated '
      end

      if request.get?
        @body_class = @border_class + params[:controller].gsub(/\//, '-') + '-' + params[:action]
      end
    end

    def set_layout
      is_user_logged_in? ? '/admin/layouts/2-column-left' : '/admin/layouts/1-column'
    end

    def is_logged_in?
      if !is_user_logged_in?
        redirect_to controller: 'index', action: 'login' and return
      end
    end
  end
end
