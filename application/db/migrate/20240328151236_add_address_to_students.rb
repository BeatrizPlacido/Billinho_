class AddAddressToStudents < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :address, :string
    add_column :students, :number, :integer
    add_column :students, :neighborhood, :string
    add_column :students, :city, :string
    add_column :students, :state, :string
    add_column :students, :cep, :string
  end
end
