// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// app/javascript/packs/application.js
import Rails from "@rails/ujs"
Rails.start()

document.addEventListener("DOMContentLoaded", function() {
    const rolAdmin = document.getElementById("rol_admin");
    const rolProfesor = document.getElementById("rol_profesor");
    const rolAlumno = document.getElementById("rol_alumno");
  
    const profesorSelect = document.getElementById("profesor-select");
    const alumnoSelect = document.getElementById("alumno-select");
  
    function toggleSelectFields() {
      profesorSelect.style.display = "none";
      alumnoSelect.style.display = "none";
  
      if (rolProfesor.checked) {
        profesorSelect.style.display = "block";
      } else if (rolAlumno.checked) {
        alumnoSelect.style.display = "block";
      }
    }
  
    rolAdmin.addEventListener("change", toggleSelectFields);
    rolProfesor.addEventListener("change", toggleSelectFields);
    rolAlumno.addEventListener("change", toggleSelectFields);
  
    // Run once on page load
    toggleSelectFields();
  });
  

