json.extract! materia, :id, :nombre, :profesor_id, :colegio_id, :created_at, :updated_at
json.url materia_url(materia, format: :json)
