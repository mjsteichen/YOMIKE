class User < ActiveRecord::Base
  has_secure_password

  validates :email, :full_name, :password_digest, :phone_number, presence: true
  validates :email, uniqueness: true

  def password
    @password ||= BCrypt::Password.new(password_digest)
  end

  def password=(submitted_password)
    @password = BCrypt::Password.create(submitted_password)
    self.password_digest = @password
  end

  def self.authenticate(email, plain_text_password)
    user = User.find_by(email: email)
    # binding.pry
    if user && user.password == plain_text_password
      return user
    end
  end
end

