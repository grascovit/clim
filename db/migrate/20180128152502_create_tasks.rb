class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :title, null: false, default: ''
      t.text :description
      t.timestamp :start_at
      t.timestamp :finish_at
      t.decimal :service_fee, precision: 10, scale: 2
      t.references :client, foreign_key: true, index: true

      t.timestamps
    end
  end
end
