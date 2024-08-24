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

  run "bundle install"

  generate "rspec:install"
  #rails_command "generate rspec:install"
end

def config_rspec
  remove_file "spec/rails_helper.rb"

  copy_file "spec/rails_helper.rb", "spec/rails_helper.rb"

  empty_directory "spec/support"

  # Copy your custom support files
  copy_file "spec/support/database_cleaner.rb", "spec/support/database_cleaner.rb"
  copy_file "spec/support/factory_bot.rb", "spec/support/factory_bot.rb"
  copy_file "spec/support/shoulda_matchers.rb", "spec/support/shoulda_matchers.rb"
end

# Main Setup
# source_path = File.expand_path(File.dirname(__FILE__))
source_paths.unshift(File.dirname(__FILE__))

add_testing_gems
config_rspec

after_bundle do
  git :init
end