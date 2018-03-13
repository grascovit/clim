class AddCpfAndCnpjToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :cpf, :string
    add_column :users, :cnpj, :string
    add_index :users, :cpf
    add_index :users, :cnpj
  end
end
