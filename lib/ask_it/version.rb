# frozen_string_literal: true

module AskIt
  VERSION = '$VERSION'
  # if VERSION is set to $VERSION, then we need to set it to the actual version
  VERSION = '1.0.1' if VERSION == '$VERSION'
end
