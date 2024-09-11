require 'rails_helper'
require 'generator_spec'
require 'generators/ask_it/survey_generator'

RSpec.describe AskIt::SurveyGenerator, type: :generator do
  destination File.expand_path('../../../tmp', __dir__)

  before(:each) do
    prepare_destination
    # create an empty config/routes.rb file with the correct structure
    FileUtils.mkdir_p(File.join(destination_root, 'config'))
    File.open(File.join(destination_root, 'config', 'routes.rb'), 'w') do |f|
      f.write("Rails.application.routes.draw do\nend\n")
    end
    allow(Rails).to receive(:root).and_return(Pathname.new(destination_root))
  end

  describe 'plain template' do
    it 'generates controllers, views, helpers, and routes' do
      run_generator ['plain']

      expect(destination_root).to(have_structure do
        directory 'app' do
          directory 'controllers' do
            file 'surveys_controller.rb'
            file 'attempts_controller.rb'
          end
          directory 'views' do
            directory 'surveys'
            directory 'attempts'
          end
          directory 'helpers' do
            directory 'ask_it' do
              file 'surveys_helper.rb'
            end
          end
        end
        directory 'config' do
          file 'routes.rb' do
            contains 'resources :surveys'
            contains 'resources :attempts, only: %i[new create]'
          end
        end
      end)
    end

    it 'generates scoped controllers, views, and routes' do
      run_generator %w[plain admin]

      expect(destination_root).to(have_structure do
        directory 'app' do
          directory 'controllers' do
            directory 'admin' do
              file 'surveys_controller.rb'
              file 'attempts_controller.rb'
            end
          end
          directory 'views' do
            directory 'admin' do
              directory 'surveys'
              directory 'attempts'
            end
          end
          directory 'helpers' do
            directory 'ask_it' do
              file 'surveys_helper.rb'
            end
          end
        end
        directory 'config' do
          file 'routes.rb' do
            contains 'namespace :admin do'
            contains 'resources :surveys'
            contains 'resources :attempts, only: %i[new create]'
          end
        end
      end)
    end
  end

  describe 'routes template' do
    it 'generates only routes' do
      run_generator ['routes']

      expect(destination_root).to(have_structure do
        directory 'config' do
          file 'routes.rb' do
            contains 'resources :surveys'
            contains 'resources :attempts, only: %i[new create]'
          end
        end
      end)

      expect(destination_root).not_to(have_structure do
        directory 'app' do
          directory 'controllers'
          directory 'views'
          directory 'helpers'
        end
      end)
    end

    it 'generates scoped routes' do
      run_generator %w[routes admin]

      expect(destination_root).to(have_structure do
        directory 'config' do
          file 'routes.rb' do
            contains 'namespace :admin do'
            contains 'resources :surveys'
            contains 'resources :attempts, only: %i[new create]'
          end
        end
      end)
    end
  end
end
