class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :volunteer, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true
      t.string :message_body
      t.integer :sender

      t.timestamps
    end
  end
end
