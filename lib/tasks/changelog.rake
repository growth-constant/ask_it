# frozen_string_literal: true

# lib/tasks/changelog.rake
require 'github_changelog_generator/task'

GitHubChangelogGenerator::RakeTask.new :changelog do |config|
  config.user = 'growth-constant'
  config.project = 'ask_it'
  # figure out future release version
  config.future_release = AskIt::VERSION
end
