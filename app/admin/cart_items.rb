ActiveAdmin.register CartItem do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :product_id, :cart_id, :quantity
  #
  # or
  #
  # permit_params do
  #   permitted = [:product_id, :cart_id, :quantity]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  ActiveAdmin.register CartItem do
  permit_params :product_id, :quantity, :cart_id

  index do
    selectable_column
    id_column
    column :product
    column :quantity
    column :cart
    actions
  end

  form do |f|
    f.inputs do
      f.input :product
      f.input :quantity
      f.input :cart
    end
    f.actions
  end
end

  
end
