class CreateScribbles < ActiveRecord::Migration[7.0]
  def change
    create_table :scribbles do |t|
      t.string :content, limit: 500, null: false
      t.string :media_url
      t.belongs_to :user, null: false
      t.timestamps
    end
  end
end
