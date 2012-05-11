ActiveRecord::Schema.define :version => 0 do
  create_table :meta_pairs do |t|
    t.string :key
    t.string :value
    t.integer :object_id, :null => false
    t.string :object_type, :null => false, :limit => 20
    t.integer :owner_id, :int
    t.string :owner_type, :limit => 20
    t.boolean :public, :default => false

    t.timestamps
  end
  add_index :meta_pairs, [:object_id, :object_type]
  add_index :meta_pairs, [:owner_id, :owner_type]
  add_index :meta_pairs, :key
end
