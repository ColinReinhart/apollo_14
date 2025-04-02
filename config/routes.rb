Rails.application.routes.draw do
  get "/astronauts", to: "astronauts#index"
  get "/astronauts/:id", to: "astronauts#show"

  resources :astronauts do
    resources :astronaut_missions, only: [:create]
  end

end
