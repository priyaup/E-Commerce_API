class ChangeForeignKeyConstraints < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :cart_items, :carts
    remove_foreign_key :cart_items, :products
    remove_foreign_key :carts, :users
    remove_foreign_key :products, :users

    add_foreign_key :cart_items, :carts, on_delete: :cascade
    add_foreign_key :cart_items, :products, on_delete: :cascade
    add_foreign_key :carts, :users, on_delete: :cascade
    add_foreign_key :products, :users, on_delete: :cascade
  end
end
