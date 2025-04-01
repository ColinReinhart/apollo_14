Rails.application.routes.draw do
  get "/astronauts", to: "astronauts#index"
  get "/astronauts/:id", to: "astronauts#show"
end
