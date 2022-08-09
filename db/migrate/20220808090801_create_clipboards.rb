class CreateClipboards < ActiveRecord::Migration[7.0]
  def change
    create_table :clipboards do |t|
      t.integer :user_id
      t.text :text

      t.timestamps
    end
  end
end
