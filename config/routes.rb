# Rails.application.routes.draw do
#   namespace :api, defaults: { format: :json } do
#     resources :users, only: %w[show]

#     devise_for :users,
#       defaults: { format: :json },
#       path: '',
#       path_names: {
#         registration: 'signup'
#       },
#       controllers: {
#         sessions: 'api/sessions',
#         registrations: 'api/registrations'
#       }
#   end
# end


Rails.application.routes.draw do
  devise_for :users,
  defaults: { format: :json },
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               sessions: 'api/sessions',
               registrations: 'api/registrations'
             }
end