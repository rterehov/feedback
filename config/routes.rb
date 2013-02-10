Feedback::Application.routes.draw do
  devise_for :users

  scope "/profile" do
    match "/" => "profile#show", :as => :profile
    match "/edit" => "profile#edit", :as => :profile_edit
    put "/" => "profile#update", :as => :profile_update
    resources :feedback do
      resources :messages
    end
  end

  root :to => "welcome#index"
end
