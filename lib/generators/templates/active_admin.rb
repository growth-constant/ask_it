# frozen_string_literal: true

ActiveAdmin.register AskIt::Survey do
  menu label: I18n.t('surveys')

  filter  :name,
          as: :select,
          collection: proc {
            AskIt::Survey.select('distinct(name)').collect do |c|
              [c.name, c.name]
            end
          }
  filter :active,
         as: :select,
         collection: %w[true false]

  filter :created_at

  index do
    column :name
    column :description
    column :active
    column :attempts_number
    column :finished
    column :created_at
    default_actions
  end

  form do |f|
    f.inputs I18n.t('survey_details') do
      f.input  :name
      f.input  :locale_name
      f.input  :description
      f.input  :locale_description
      f.input  :active, as: :select, collection: %w[true false]
      f.input  :attempts_number
    end

    f.inputs I18n.t('sections') do
      f.has_many :sections do |s|
        s.input :head_number
        s.input :locale_head_number
        s.input :name
        s.input :locale_name
        s.input :description
        s.input :locale_description

        s.has_many :questions do |q|
          q.input :head_number
          q.input :locale_head_number
          q.input :text
          q.input :locale_text
          q.input :description
          q.input :locale_description
          q.input :questions_type_id, as: :select, collection: AskIt::QuestionsType.questions_types_title
          q.input :mandatory

          q.inputs I18n.t('predefined_values') do
            q.has_many :predefined_values do |p|
              p.input :head_number
              p.input :name
              p.input :locale_name
            end
          end

          q.has_many :options do |a|
            a.input :head_number
            a.input :text
            a.input :locale_text
            a.input :options_type_id, as: :select, collection: AskIt::OptionsType.options_types_title
            a.input :correct
          end
        end
      end
    end

    f.buttons
  end

  if Rails::VERSION::MAJOR >= 4
    controller do
      def permitted_params
        params.permit!
      end
    end
  end
end
