class CreateOrganizations < ActiveRecord::Migration[7.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :contact_phone
      t.string :contact_email
      t.string :street_address
      t.string :website
      t.string :city
      t.string :state
      t.string :zip
      t.boolean :share_address
      t.boolean :share_phone
      t.boolean :share_email

      t.timestamps
    end
  end
end
