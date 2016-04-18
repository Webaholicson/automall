class User < ActiveRecord::Base
  validates :first_name, :last_name, presence: true, length: { minimum: 2 }
  validates :email, presence: true, confirmation: true, uniqueness: true
  validates_format_of :email, :with => /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :password, presence: true, length: { minimum: 6 }

  def register(params)
    self.first_name = params[:first_name]
    self.last_name = params[:last_name]
    self.email = params[:email]
    self.email_confirmation = params[:email_confirmation]
    self.password = params[:password]

    if params[:email] != params[:email_confirmation]
      raise I18n.t :email_confirmation_error
    end

    if !save!
      raise I18n.t :user_was_not_saved
    end
  end
end
