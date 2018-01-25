class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :primary_address, null: false, default: ''
      t.string :secondary_address
      t.string :number
      t.string :zip_code
      t.string :neighborhood
      t.string :city, null: false, default: ''
      t.string :state, null: false, default: ''
      t.string :country, null: false, default: ''
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.references :addressable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
