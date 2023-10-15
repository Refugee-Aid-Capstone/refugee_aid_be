class CreateAidRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :aid_requests do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :aid_type
      t.string :language
      t.text :description
      t.string :status, default: "active"

      t.timestamps
    end
  end
end
