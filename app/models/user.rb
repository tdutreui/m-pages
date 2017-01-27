class User < ActiveRecord::Base
    acts_as_authentic
    validates :name, length: {maximum: 50}
    has_many :pages

    def deliver_password_reset_instructions!
	reset_perishable_token!
	PasswordResetMailer.reset_email(self).deliver_now
    end

end
