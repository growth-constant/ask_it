# frozen_string_literal: true

module AskIt
  module SurveysHelper
    def link_to_remove_field(name, field)
      field.hidden_field(:_destroy) +
        link_to_function(raw(name), 'removeField(this)', id: 'remove-attach')
    end

    def new_attempt_path
      new_attempt_path
    end

    def new_survey_path
      new_survey_path
    end

    def edit_survey_path(resource)
      edit_survey_path(resource)
    end

    def attempt_scope(resource)
      if action_name =~ /new|create/
        attempts_path(resource)
      elsif action_name =~ /edit|update/
        attempt_path(resource)
      end
    end

    def survey_scope(resource)
      if action_name =~ /new|create/
        surveys_path(resource)
      elsif action_name =~ /edit|update/
        survey_path(resource)
      end
    end

    def link_to_add_field(name, field, association)
      new_object = field.object.class.reflect_on_association(association).klass.new
      fields = field.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
        render("#{association.to_s.singularize}_fields", f: builder)
      end
      link_to_function(name, "addField(this, \"#{association}\", \"#{escape_javascript(fields)}\")",
                       id: 'add-attach',
                       class: 'btn btn-small btn-info')
    end

    def link_to_function(name, *args, &block)
      html_options = args.extract_options!.symbolize_keys

      function = block_given? ? update_page(&block) : args[0] || ''
      onclick = "#{"#{html_options[:onclick]}; " if html_options[:onclick]}#{function}; return false;"
      href = html_options[:href] || '#'

      content_tag(:a, name, html_options.merge(href: href, onclick: onclick))
    end
  end
end
