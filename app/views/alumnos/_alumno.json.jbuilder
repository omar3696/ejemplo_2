json.extract! alumno, :id, :nombre, :colegio_id, :created_at, :updated_at
json.url alumno_url(alumno, format: :json)
