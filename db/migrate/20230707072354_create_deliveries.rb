class CreateDeliveries < ActiveRecord::Migration[7.0]
  def change
    create_table :deliveries do |t|
      t.string :post_code, null: false
      t.string :prefecture, null: false
      t.string :municipality, null: false
      t.string :address, null: false
      t.string :building_name, null: false
      t.string :telephone_number, null: false
      t.references :buy, null: false, foreign_key: true
      t.timestamps
    end
  end
end
