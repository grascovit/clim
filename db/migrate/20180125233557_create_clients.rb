class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :phone
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
