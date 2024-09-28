ActiveAdmin.register Product do
  permit_params :name, :description, :price, :user_id

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :user
    actions
  end

  form do |f|
    f.inputs "Product Details" do
      f.input :name
      f.input :description
      f.input :price
      f.input :user, as: :select, collection: User.all.collect { |user| [user.email, user.id] }
    end
    f.actions
  end

  filter :name
  filter :price
  filter :user
end
