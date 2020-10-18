class AddArticlesCountToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :articles_count, :integer, default: 0
  end
end
