class User < ActiveRecord::Base
  acts_as_authentic
  attr_accessible :email, :password, :password_confirmation

  after_create :send_signup_confirmation!

  def send_signup_confirmation!
    reset_perishable_token!
    UserSignup.deliver_confirmation_email(self)
  end

  def activate!
    self.activated = true
    self.save_without_session_maintenance
  end
end