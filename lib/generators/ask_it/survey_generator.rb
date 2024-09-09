# frozen_string_literal: true

module AskIt
  class SurveyGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __dir__)

    TEMPLATES = %w[active_admin rails_admin plain routes].freeze

    argument :arguments,
             type: :array,
             default: [],
             banner: "< #{TEMPLATES.join('|')} > [scope]"

    def create_resolution
      strategy = arguments.first
      if TEMPLATES.include? strategy
        send("generate_#{strategy}_resolution")
        success_message(strategy)
      else
        error_message(strategy)
      end
    end

    private

    def generate_active_admin_resolution
      copy_file 'active_admin.rb', 'app/admin/survey.rb'
    end

    def generate_rails_admin_resolution
      copy_file 'rails_admin.rb', 'config/initializers/survey_rails_admin.rb'
    end

    def generate_plain_resolution
      scope = get_scope
      generate_controller(scope)
      generate_views(scope)
      generate_helpers(scope)
      generate_routes_for(scope)
    end

    def generate_routes_resolution
      generate_routes_for(get_scope)
    end

    def generate_controller(scope)
      template 'controllers/surveys_controller.rb', controller_path(scope)
      template 'controllers/attempts_controller.rb', attempts_controller_path(scope)
    end

    def generate_helpers(_scope)
      survey_helper_path = 'app/helpers/ask_it/surveys_helper.rb'
      template 'helpers/ask_it/surveys_helper.rb', survey_helper_path
    end

    def generate_views(scope)
      view_path = scope.present? ? "app/views/#{scope}" : 'app/views'
      directory 'views/surveys', "#{view_path}/surveys", recursive: true
      directory 'views/attempts', "#{view_path}/attempts", recursive: true
    end

    def generate_routes_for(scope)
      inject_into_file 'config/routes.rb',
                       after: 'Rails.application.routes.draw do' do
        if scope.blank?
          <<-CONTENT

  resources :surveys
  resources :attempts, only: %i[new create]
          CONTENT
        else
          <<-CONTENT

  namespace :#{scope} do
    resources :surveys
    resources :attempts, only: %i[new create]
  end
          CONTENT
        end
      end
    end

    def get_scope
      arguments.size > 1 ? arguments[1] : nil
    end

    def get_scope_path
      get_scope.present? ? "#{get_scope}_" : ''
    end

    def get_controller_scope
      scope = get_scope
      scope.present? ? "#{scope.capitalize}::" : ''
    end

    def controller_path(scope)
      scope.present? ? "app/controllers/#{scope}/surveys_controller.rb" : 'app/controllers/surveys_controller.rb'
    end

    def attempts_controller_path(scope)
      scope.present? ? "app/controllers/#{scope}/attempts_controller.rb" : 'app/controllers/attempts_controller.rb'
    end

    # Error Handlers
    def error_message(argument)
      error_message = <<-CONTENT
        This Resolution: '#{argument}' is not supported by Survey:
        We only support Active Admin, Rails Admin, Plain, and Routes
      CONTENT
      say error_message, :red
    end

    def success_message(argument)
      say "Generation of #{argument.capitalize} Template Complete :) enjoy Survey", :green
    end
  end
end
