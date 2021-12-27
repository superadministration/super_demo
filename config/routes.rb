Rails.application.routes.draw do
  namespace :admin do
    resources :orders
    resources :customers
    resources :products
    root to: redirect(path: "/admin/orders", status: 302)
  end

  root to: redirect(path: "/admin/orders", status: 302)
end
