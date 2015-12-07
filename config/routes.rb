ReadingList::Application.routes.draw do
  resources :books
  resources :finished_books
  # note that this we are parsing finished books out into it's own
  # resource instead of just adding a filter param to books. it's a judgement
  # call but we do this when we think this endpoint merits it's own resource. Being
  # RESTful
  resources :genres
end
