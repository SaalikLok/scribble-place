class IncreaseScribbleContentCharLimit < ActiveRecord::Migration[7.0]
  def change
    change_column :scribbles, :content, :text, limit: 10000
  end
end
