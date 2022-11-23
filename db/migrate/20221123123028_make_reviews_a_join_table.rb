class MakeReviewsAJoinTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :name, :string
    add_column :user_id, :integer
  end
end
