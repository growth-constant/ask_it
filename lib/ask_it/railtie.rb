module AskIt 
  class Railtie < ::Rails::Railtie
    generators do
      require 'ask_it/generators/ask_it/install_generator'
    end
  end
end
