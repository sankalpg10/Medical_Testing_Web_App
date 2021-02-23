class AddPriceTipsToSampleCollections < ActiveRecord::Migration[6.0]
  def change
    add_column :sample_collections, :price, :integer
    add_column :sample_collections, :sample_tips, :string
  end
end
