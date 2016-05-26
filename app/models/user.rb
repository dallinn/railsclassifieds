class User < ActiveRecord::Base

	has_secure_password

	has_many :posts

	EMAILREGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

    validates :first_name, 	:presence => true,
                         	:length => { :maximum => 25 }
                            
    validates :last_name, 	:presence => true,
                        	:length => { :maximum => 50 }

    validates :username,	:length => { :within => 4..25 },
                       		:uniqueness => true

    validates :email, 		:presence => true,
							:length => { :maximum => 100 },
                            :uniqueness => true,
							:format => EMAILREGEX,
							:confirmation => true

    # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
