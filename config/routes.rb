require 'sidekiq/web'

Rails.application.routes.draw do

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations:      'users/registrations',
    password:           'users/passwords'
  }

  devise_scope :user do
    patch 'users/registrations/parent_email' => 'users/registrations#parent_email',   as: :update_parent_email
    get   '/:type/sign_up', to: 'users/registrations#new', type: /teachers|students/, as: :sign_up
    get   'users/sign_up/complete' => 'users/registrations#complete'
  end

  mount LetterOpenerWeb::Engine => "/letter_opener" if Rails.env.development? || Rails.env.staging?
  mount Staffroom::Engine       => '/staffroom'
  mount Sidekiq::Web            => '/sidekiq'

  resources :users, module: :users do
    resources :messages
    resources :transaction_records
    resource  :inbox
  end

  resources :tutor_logs
  resources :students, module: :students do
    resources :tutor_logs, only: :index
    resources :tutor_logs, path: 'tutor_logs/:number', except: [:index]
    resources :after_interview_logs
    resources :interview_logs
    resources :lesson_logs
    resources :monthly_fees
    resources :lessons do
      resources :student_reports
    end
    #resources :lessons, module: :lessons do
    #  resources :parent_logs
    #  resources :parent_greeting_logs
    #end
    resources :logs
    resources :past_lessons
    resources :student_reports
    namespace :yomikos do
      resources :trial_test_logs
      resources :exam_school_logs
      resources :kakomon_logs
    end
    resources :parent_logs do
      collection do
        get 'select'
      end
    end

    resources :parent_greeting_logs
    resources :yomikos
    resource  :mypage
    resource  :profile
    resource  :text_use
  end

  resources :teachers, module: :teachers do
    resources :lessons
    resources :past_lessons
    resources :posts
    resources :reviews
    resources :schedules
    resources :teacher_logs
    resources :teacher_setting_targets

    resource  :information
    resource  :mypage
    resource  :profile
  end

  resources :experience_notes
  resources :experience_note_admins, only: [:show]
  resources :breach_reports
  resources :feedbacks
  resources :inquiries
  resources :likes
  resources :monthly_reports do
    get :report
  end
  resources :notifications
  resources :payforwards
  resources :posts
  resources :registration_wizard
  resources :replies
  resources :reviews

  resource  :text_request, only: [:create]
  resource  :actions
  resource  :timeline
  resource  :trials
  resource  :teacher_log, only: [:show]


  patch 'auto_save_posts/update' => 'auto_save_posts#update'


  get   'reviews/new_for_pf_introducer/:introduced_id' => 'reviews#new_for_pf_introducer', as: :new_for_pf_introducer
  get   'reviews/new_for_teacher/:introduced_id'       => 'reviews#new_for_teacher',       as: :new_for_teacher
  patch 'reviews/update_for_teacher/:id'               => 'reviews#update_for_teacher',    as: :update_for_teacher

  resources :students do
    get 'reports/image_destroy/:image_id' => 'reports#image_destroy', as: :report_image_destroy
  end

  resources :administrators, except: [:show, :update]
  get 'administrators/teacher_select/:student_id' => 'administrators#teacher_select',as: :teacher_select
  get 'administrators/confirmation' => 'administrators#confirmation'
  get 'administrators/select' => 'administrators#select',as: :select
  get 'administrators/messages' => 'administrators#messages'
  get 'administrators/skip_confirmation' => 'administrators#skip_confirmation'
  get 'administrators/permit_publish' => 'administrators#permit_publish',as: :permit_publish
  get 'administrators/edit_parent_email' =>  'administrators#edit_parent_email', as: :edit_parent_email
  get 'administrators/data_collection_students' => 'administrators#data_collection_students', as: :data_collection_students
  get 'administrators/data_collection_teachers' => 'administrators#data_collection_teachers', as: :data_collection_teachers
  get 'administrators/repost_data' => 'administrators#repost_data', as: :repost_data
  get 'administrators/reply_data' => 'administrators#reply_data', as: :reply_data
  get 'administrators/teacher_fact_index', as: :teacher_fact_index
  get 'administrators/teacher_fact/:id' => 'administrators#teacher_fact', as: :teacher_fact
  get 'administrators/student_fact_index',  as: :student_fact_index
  get 'administrators/select_date', as: :select_date
  get 'administrators/teacher_fact_custom', as: :teacher_fact_custom
  patch 'administrators/weekrepo_status/:id' => 'administrators#weekrepo_status', as: :weekrepo_status
  patch 'administrators/update_skype/:id' => 'administrators#update_skype', as: :update_skype
  get 'administrators/select_for_like_count' => 'administrators#select_for_like_count', as: :select_for_like_count
  post 'administrators/like_count' => 'administrators#like_count', as: :like_count

  get  '/series/sakura' => 'pages#sakura'
  get  '/series/s'   => 'pages#s'
  get  '/staffs'     => 'pages#staffs'
  get  '/staffs/:id' => 'pages#staff', as: 'staff'
  get  '/parents'    => 'pages#parents'
  get  '/trial'      => 'pages#trial'
  get  '/price'      => 'pages#price'
  get  '/story'      => 'pages#story'
#テスト追加 -S
  get  '/experience_story'      => 'pages#experience_story'
  get  '/2017001'      => 'pages#2017001'
  get  '/2017002'      => 'pages#2017002'
  get  '/2017003'      => 'pages#2017003'
  get  '/2017004'      => 'pages#2017004'
  get  '/2017005'      => 'pages#2017005'
  get  '/2017006'      => 'pages#2017006'
  get  '/2017007'      => 'pages#2017007'
  get  '/2017008'      => 'pages#2017008'
  get  '/2017009'      => 'pages#2017009'
  get  '/2017010'      => 'pages#2017010'
  get  '/2017011'      => 'pages#2017011'
  get  '/2017012'      => 'pages#2017012'
  get  '/2017013'      => 'pages#2017013'
  get  '/2017014'      => 'pages#2017014'
  get  '/2017015'      => 'pages#2017015'
  get  '/2017016'      => 'pages#2017016'
  get  '/2017017'      => 'pages#2017017'
#テスト追加 -E

  get  '/top'        => 'pages#top'
  get  '/explain/logs' => 'pages#explain_logs'
  get  '/explain/reports' => 'pages#explain_reports'
  root 'pages#top'
end
