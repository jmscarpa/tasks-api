Rails.application.routes.draw do
  scope defaults: { format: :json } do
    get '/', controller: :status, action: :index
    resources :tasks
  end
end
