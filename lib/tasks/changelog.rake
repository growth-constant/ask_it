# lib/tasks/changelog.rake
require 'github_changelog_generator/task'

GitHubChangelogGenerator::RakeTask.new :changelog do |config|
  config.user = 'growthconstant'
  config.project = 'ask_it'
  config.future_release = AskIt::VERSION
end
