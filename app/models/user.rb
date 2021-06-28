class User < ActiveRecord::Base

  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 5 }
  has_secure_password
  
  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.downcase.strip)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

end
