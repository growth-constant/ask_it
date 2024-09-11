# frozen_string_literal: true

require 'rails_helper'
require 'generator_spec'
require 'generators/ask_it/install_generator'

RSpec.describe AskIt::Generators::InstallGenerator, type: :generator do
  destination File.expand_path('../../../tmp', __dir__)

  before(:each) do
    prepare_destination
  end

  it 'creates migration files' do
    run_generator

    expect(destination_root).to(have_structure do
      directory 'db' do
        directory 'migrate' do
          migration 'create_survey'
          migration 'create_sections'
          migration 'update_survey_tables'
          migration 'add_types_to_questions_and_options'
          migration 'add_head_number_to_options_table'
          migration 'create_predefined_values_table'
          migration 'add_mandatory_to_questions_table'
        end
      end
    end)
  end

  it 'does not create duplicate migration files' do
    run_generator
    run_generator

    migration_files = Dir.glob("#{destination_root}/db/migrate/*")
    unique_migration_names = migration_files.map { |f| f.split('_')[1..].join('_') }.uniq
    expect(unique_migration_names.size).to eq(7)
  end

  it 'includes migration version for Rails 4' do
    stub_const('Rails::VERSION::MAJOR', 4)
    stub_const('Rails::VERSION::MINOR', 2)
    run_generator

    migration_file = Dir.glob("#{destination_root}/db/migrate/*create_survey.rb").first
    expect(File.read(migration_file)).to include('ActiveRecord::Migration')
  end

  it 'includes migration version for Rails 5 and up' do
    stub_const('Rails::VERSION::MAJOR', 5)
    stub_const('Rails::VERSION::MINOR', 0)
    run_generator

    migration_file = Dir.glob("#{destination_root}/db/migrate/*create_survey.rb").first
    expect(File.read(migration_file)).to include('ActiveRecord::Migration[5.0]')
  end

  it 'does not include migration version for Rails 7' do
    stub_const('Rails::VERSION::MAJOR', 7)
    stub_const('Rails::VERSION::MINOR', 0)
    run_generator

    migration_file = Dir.glob("#{destination_root}/db/migrate/*create_survey.rb").first
    expect(File.read(migration_file)).to include('ActiveRecord::Migration[7.0]')
  end
end
