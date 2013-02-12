Feedback::Application.routes.draw do
  resources :messages

  root :to => "welcome#index"
  match "/about" => "welcome#about", :as => :about_page
  match "/contacts" => "welcome#contacts", :as => :contacts
  match "" => "welcome#about", :as => :about 

  devise_for :users

  scope "/profile" do
    match "/" => "profile#show", :as => :profile
    resources :sites do
      resources :messages
    end
    match "/messages" => "messages#index", :as => :messages
  end

  match "/form_post/:id" => "sites#form_post", :as => :form_post
  match "/form_page/:site_id" => "messages#new_for_site", :as => :form_page

end
