class AdminUser < ActiveRecord::Base
  validates :first_name, :last_name, :username, presence: true, length: { minimum: 2 }
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :password, presence: true, length: { minimum: 6 }
  validates :password, confirmation: true, if: :has_confirmation?

  def has_confirmation?
    !self.password_confirmation.nil?
  end

  def set_already_confirmed
    if !self.approval_code.nil? and self.active
      self.approval_code = nil
      save
    end
  end
end
