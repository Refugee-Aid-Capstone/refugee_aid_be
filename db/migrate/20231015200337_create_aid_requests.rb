class CreateAidRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :aid_requests do |t|
      t.references :organization, null: false, foreign_key: true
      t.integer :aid_type
      t.string :language
      t.string :description
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
