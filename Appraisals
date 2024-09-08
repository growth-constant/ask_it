# frozen_string_literal: true

# appraise 'rails_5.2.2' do
# gem 'rails', '~> 5.2.2'

# gemfile.platforms :jruby do
# gem 'activerecord-jdbcsqlite3-adapter'
# gem 'jdbc-sqlite3'
# gem 'jdbc-postgres'
# end

# gemfile.platforms :ruby, :mswin, :mingw do
# gem 'pg', '~> 1.3.4'
# gem 'sqlite3', '~> 1.7.3'
# end
# end

# appraise 'rails_6.0.0' do
#   gem 'rails', '~> 6.0'
#
#   platforms :ruby, :mswin, :mingw do
#     gem 'pg', '~> 1.3.4'
#     #gem 'sqlite3', '~> 1.7.3'
#   end
# end

appraise 'rails_6.1.0' do
  gem 'rails', '~> 6.1.0'
  gem 'bootsnap'
  remove_gem 'net-protocol'

  platforms :ruby, :mswin, :mingw do
    gem 'pg', '~> 1.3.4'
    # gem 'sqlite3', '~> 1.7.3'
  end
end

appraise 'rails_7.0.0' do
  gem 'bootsnap'
  gem 'rails', '~> 7.0.0'
  # env 'RAILS_LOCATION' => 'spec/dummy_700'

  platforms :ruby, :mswin, :mingw do
    gem 'pg', '~> 1.3.4'
    # gem 'sqlite3', '~> 1.7.3'
  end
end

appraise 'rails_7.1.0' do
  gem 'bootsnap'
  gem 'rails', '~> 7.1.0'
  # env 'RAILS_LOCATION' => 'spec/dummy_710'

  platforms :ruby, :mswin, :mingw do
    gem 'pg', '~> 1.5.6'
    # gem 'sqlite3', '~> 1.7.3'
  end
end
