class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.string  :hashed_key, :null => false, :length => 255
      t.index   :hashed_key
      t.boolean :enabled, :default => true, :null => false
      t.integer :owner_id, :null => false
      t.timestamps
    end
  end
end
