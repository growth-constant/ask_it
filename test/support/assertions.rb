# frozen_string_literal: true

require 'active_support/test_case'

module ActiveSupport
  class TestCase
    def should_be_true(assertion)
      assert assertion
    end

    def should_be_false(assertion)
      assert !assertion
    end

    def assert_not_with_message(assertion, message)
      assert !assertion, message
    end

    def assert_blank(assertion)
      should_be_true assertion.blank?
    end

    def assert_not_blank(assertion)
      assert assertion.present?
    end

    def assert_not_nil(assertion)
      should_be_true !assertion.nil?
    end

    def should_be_persisted(assertion)
      should_be_true   assertion.valid?
      should_be_false  assertion.new_record?
    end

    def should_not_be_persisted(assertion)
      should_be_true   assertion.new_record?
      should_be_false  assertion.valid?
    end
  end
end
