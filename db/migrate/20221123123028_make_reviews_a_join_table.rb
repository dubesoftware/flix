class MakeReviewsAJoinTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :name, :string
  end
end
