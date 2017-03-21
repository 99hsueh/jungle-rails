class User < ActiveRecord::Base

  has_secure_password
  has_many :orders
  has_many :reviews

  def self.authenticate_with_credentials(email, password)
    email = email.downcase.strip
    user = User.find_by(email: email)
    if user && user.authenticate(password)
      user
    end
  end

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email,
            presence: true,
            format: { without: /\s/ },
            uniqueness: { case_sensitive: false, message: "This email has already been registered!" }
  validates :password,
            presence: true,
            length: { in: 5..20 }
end
