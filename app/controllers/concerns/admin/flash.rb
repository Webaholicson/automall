module Admin
  module Flash
    extend ActiveSupport::Concern

    included do
      before_action :setup_admin_flash_auto, :load_flash_messages
    end

    protected

    def get_flash
      setup_admin_flash
      flash[:admin]
    end

    def flash_get(key)
      get_flash()[key]
    end

    def flash_set(key, value)
      get_flash()[key] = value
    end

    def set_flash_message(type, message)
      get_flash()['messages'][type] = message
    end

    def setup_admin_flash
      if request.post? and flash[:admin].nil?
        flash[:admin] = Hash.new
        flash[:admin]['messages'] = Hash.new
      end
    end

    private

    def setup_admin_flash_auto
      setup_admin_flash
    end

    def load_flash_messages(type = nil)
      @messages = nil;
      if !get_flash().nil?
        if type.nil?
          @messages = get_flash()['messages']
        else
          @messages = get_flash()['messages'][type]
        end
      end
      @messages
    end
  end
end
