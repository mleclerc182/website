class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, password_length: 8..128

 has_many :posts
 has_many :comments, dependent: :destroy
 belongs_to :plan
 has_one :profile

 validate :password_complexity
 validate :username_exists


  def password_complexity
    if password.present?
      unless password.match(/^(?=.*[a-z])(?=.*[A-Z])/)
        errors.add :password, " Complexity requirement not mets"
      end
    end
  end

  def username_exists
    if User.exists?(username: username)
      errors.add(:username, "already exists")
    end
  end

end

