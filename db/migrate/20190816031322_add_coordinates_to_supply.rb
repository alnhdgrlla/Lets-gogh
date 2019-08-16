class AddCoordinatesToSupply < ActiveRecord::Migration[5.2]
  def change
    add_column :supplies, :latitude, :float
    add_column :supplies, :longitude, :float
  end
end
