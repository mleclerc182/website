class Profile < ApplicationRecord
belongs_to :user
validates :first_name, presence: true, allow_blank: false
validates :last_name, presence: true, allow_blank: false
validates :job_title, presence: true, allow_blank: false
validates :phone_number, presence: true, allow_blank: false
validates :contact_email, presence: true, allow_blank: false
validates :description, presence: true, allow_blank: false


end