#\ -b 0.0.0.0 -p 8080

require ::File.expand_path('../config/environment', __FILE__)
run Rails.application
