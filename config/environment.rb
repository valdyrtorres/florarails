# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Florarails::Application.initialize!

I18n.load_path << Dir[File.join(Rails.root, 'my', 'locales', '*.{rb,yml}')]
I18n.default_locale = :pt_BR

# specifically set the paperclip path
Paperclip.options[:command_path] = '/usr/local/bin'