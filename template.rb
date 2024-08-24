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

  generate("rspec:install")
end

add_testing_gems

source_path = File.expand_path(File.dirname(__FILE__))

remove_file "spec/rails_helper.rb"

copy_file "#{source_path}/spec/rails_helper.rb", "spec/rails_helper.rb"

empty_directory "spec/support"

# Copy your custom support files
copy_file "#{source_path}/spec/support/database_cleaner.rb", "spec/support/database_cleaner.rb"
copy_file "#{source_path}/spec/support/factory_bot.rb", "spec/support/factory_bot.rb"
copy_file "#{source_path}/spec/support/shoulda_matchers.rb", "spec/support/shoulda_matchers.rb"
after_bundle do
  git :init
end