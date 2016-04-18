module Admin
  class AdminController < ApplicationController
    include ApplicationHelper
    include Session
    include Flash

    before_action :set_body_class

    private

    def set_body_class
      if request.get?
        @body_class = params[:controller].gsub(/\//, '-') + '-' + params[:action]
      end
    end
  end
end
