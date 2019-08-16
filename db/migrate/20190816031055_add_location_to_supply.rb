class AddLocationToSupply < ActiveRecord::Migration[5.2]
  def change
    add_column :supplies, :location, :string
  end
end
