class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :body, presence: true, allow_blank: false
  has_rich_text :body
end
