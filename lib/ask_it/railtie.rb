module AskIt 
  class Railtie < ::Rails::Railtie
    generators do
      require 'ask_it/generators/ask_it/install_generator'
    end

    initializer 'ask_it.load_models' do |app|
      app.config.paths.add 'app/models/ask_it', eager_load: true
    end
  end
end
