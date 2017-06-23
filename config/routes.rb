Rails.application.routes.draw do
  resources :settings
  resources :interviews
  get 'home/index'
  root to: 'home#index'

  resources :university_choices
  resources :placements do
	collection do
         post 'match'
  	end
  end
  resources :exam_results
  resources :exams
  resources :program_quota
  resources :program_choices
  resources :applicants
  resources :universities
  resources :programs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
