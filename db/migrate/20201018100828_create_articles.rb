class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.string :uid, null: false, index: { unique: true }
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.boolean :published, default: false
      t.datetime :published_at
      t.boolean :pinned, default: false
      t.text :search

      t.timestamps
    end
  end
end
