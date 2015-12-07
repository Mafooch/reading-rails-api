ReadingList::Application.routes.draw do
  resources :books, only: :index
end
