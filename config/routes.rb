Rails.application.routes.draw do
  devise_for :usuarios
  resources :notas
  resources :materias
  resources :alumnos
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
end
