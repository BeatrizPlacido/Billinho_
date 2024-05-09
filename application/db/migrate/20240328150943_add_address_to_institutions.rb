class AddAddressToInstitutions < ActiveRecord::Migration[7.1]
  def change
    add_column :institutions, :address, :string
    add_column :institutions, :number, :integer
    add_column :institutions, :neighborhood, :string
    add_column :institutions, :city, :string
    add_column :institutions, :state, :string
    add_column :institutions, :cep, :string
  end
end
