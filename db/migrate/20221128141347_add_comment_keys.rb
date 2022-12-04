class AddCommentKeys < ActiveRecord::Migration[6.1]
  def change
    #add_column :users, :comment_id, :integer
    #add_column :posts, :comment_id, :integer
    add_column :comments, :post_id, :integer
    add_column :comments, :user_id, :integer
  end
end
