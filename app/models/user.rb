class User < ApplicationRecord
    has_secure_password
    
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    
    before_save :downcase_email

    has_many :user_tokens
    
    def downcase_email
        self.email = self.email.delete(' ').downcase
    end
end
