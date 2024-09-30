Rails.application.routes.draw do
  devise_for :usuarios
  resources :notas do
    collection do
      get :exportar_excel_aprobados
      get :exportar_excel_reprobados
      get :exportar_excel_todos
    end
  end
  resources :materias
  resources :alumnos do
    member do
      get "generar_pdf", defaults: { format: :pdf }
    end
  end
  resources :profesores
  resources :colegios

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Ruta para verificar la salud de la aplicación
  get "up" => "rails/health#show", as: :rails_health_check

  # Rutas para PWA
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Ruta raíz para usuarios autenticados
  authenticated :usuario do
    root 'colegios#index', as: :authenticated_root
  end

  # Ruta raíz para usuarios no autenticados
  unauthenticated do
    root 'devise#sessions', as: :unauthenticated_root
  end

  # Esta línea se elimina para evitar conflicto
  # root to: 'home#index'
  namespace :api do
    get 'notas', to: 'alumno_api#nota_carnet'
  end

  post 'login', to: 'sesion#create'
end
