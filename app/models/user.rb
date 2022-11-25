class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, password_length: 8..128

  validate :password_complexity


  def password_complexity
    if password.present?
      unless password.match(/^(?=.*[a-z])(?=.*[A-Z])/)
        errors.add :password, " complexity requirement not met"
      end
    end
  end

end

