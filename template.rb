# Update RubyGems to the latest version or a compatible version
# run "gem update --system 3.1.2"

# gem 'rails', '6.1.0'

# gem 'ffi', '~> 1.15'

# Add RSpec and Supporting gems
def add_testing_gems
  gem_group :development, :test do
    gem 'rspec-rails'
    gem 'factory_bot_rails'
    gem 'faker'
    gem 'guard'
    gem 'guard-rspec'
  end

  gem_group :test do
    gem 'shoulda-matchers'
    gem 'database_cleaner'
    gem 'database_cleaner-active_record'
  end
end

def config_rspec
  generate "rspec:install"
  #rails_command "generate rspec:install"
  remove_file "spec/rails_helper.rb"

  copy_file "spec/rails_helper.rb"

  directory "spec/support"

  append_to_file '.rspec', "--format documentation\n--color"
end

# Main Setup
source_paths.unshift(File.dirname(__FILE__))

add_testing_gems

after_bundle do
  config_rspec

  git :init

  say
  say "Template RBP Done!", :blue
  say
  say "To get started with your new app:", :green
  say "  cd #{original_app_name}"
  say
  say "  # Update config/database.yml with your database credentials"
  say
  say "  rails db:create"
  say "  rails db:migrate"
  say "  bin/dev"
end