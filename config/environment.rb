# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Newsocial::Application.initialize!

Paperclip.options[:command_path] = "C:\\ImageMagick-6.7.0-3"

