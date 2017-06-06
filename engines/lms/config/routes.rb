Lms::Engine.routes.draw do
  root to: "pages#home"
  get 'auth' => "pages#auth"
  get "help" => "pages#help"

  resources :courses do
    resources :assignments
    resources :lessons do
      resources :comments, only: [:create, :destroy]
    end
  end

  get "/students/:id/add_course" => "student_addons#add_course", as: :add_course_student
  delete "/students/:id/leave_course/:course_id" => "student_addons#leave_course", as: :leave_course_student

  patch "/student_assignments/:id/complete" => "student_addons#complete_assignment", as: :complete_student_assignment
  patch "/student_assignments/:id/uncomplete" => "student_addons#uncomplete_assignment", as: :uncomplete_student_assignment

  post "/courses/:id/add_link" => "addons#add_link", as: :add_link_course
  delete "/courses/:id/delete_link/:link_id" => "addons#delete_link", as: :delete_link_course

end
