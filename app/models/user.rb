class User < ApplicationRecord
  before_save {self.email = email.downcase}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255},
  format: {with: VALID_EMAIL_REGEX},
  uniqueness: { case_sensitive: false }
  validates :password, length: {minimum: 6}, allow_blank: true

  has_secure_password

  #returns the hash digest for the given password
  def User.digest(pw)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(pw, cost: cost)
  end

  #returns a random 16bit base64 string
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  #sets the remember_digest column in the database to be the
  #digest of the User.new_token string
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  #sets the remember_digest column in the database to nil
  def forget
    update_attribute(:remember_digest, nil)
  end

  #checks if the given token matches the digest in the db that we
  #set in the remember method
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

end
