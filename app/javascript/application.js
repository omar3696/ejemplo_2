// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", function() {
    var flashAlert = document.getElementById('flash-alert');
    if (flashAlert) {
      setTimeout(function() {
        flashAlert.style.display = 'none';
      }, 5000); // 5000ms = 5 segundos
    }
  });
