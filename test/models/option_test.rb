# frozen_string_literal: true

require 'test_helper'

class OptionTest < ActiveSupport::TestCase
  test 'should create a valid option' do
    option = create_option
    should_be_persisted option
  end

  test 'should create a valid option with multi choices type' do
    option = create_option(options_type_id: AskIt::OptionsType.multi_choices)

    should_be_persisted option
    assert_equal option.options_type_id, AskIt::OptionsType.multi_choices
  end

  test 'should create a valid option with single choice type' do
    option = create_option(options_type_id: AskIt::OptionsType.single_choice)

    should_be_persisted option
    assert_equal option.options_type_id, AskIt::OptionsType.single_choice
  end

  test 'should create a valid option with number type' do
    option = create_option(options_type_id: AskIt::OptionsType.number)

    should_be_persisted option
    assert_equal option.options_type_id, AskIt::OptionsType.number
  end

  test 'should create a valid option with text type' do
    option = create_option(options_type_id: AskIt::OptionsType.text)

    should_be_persisted option
    assert_equal option.options_type_id, AskIt::OptionsType.text
  end

  test 'should create a valid option with large_text type' do
    option = create_option(options_type_id: AskIt::OptionsType.large_text)

    should_be_persisted option
    assert_equal option.options_type_id, AskIt::OptionsType.large_text
  end

  test 'should create a valid option with accepted type' do
    option = create_option(options_type_id: 99)

    should_not_be_persisted option
  end

  test 'should not create an option with a empty or nil options_type_id field' do
    option = create_option(options_type_id: nil)

    should_not_be_persisted option
  end

  test 'should create a option with empty or nil text fields for text or number types' do
    optionA = create_option(text: '', options_type_id: AskIt::OptionsType.text)
    optionB = create_option(text: nil, options_type_id: AskIt::OptionsType.text)

    optionC = create_option(text: '', options_type_id: AskIt::OptionsType.number)
    optionD = create_option(text: nil, options_type_id: AskIt::OptionsType.number)

    should_be_persisted optionA
    should_be_persisted optionB

    should_be_persisted optionC
    should_be_persisted optionD
  end

  test 'should not create a option with empty or nil text fields for multi_choices or single_choice types' do
    option_a = create_option(text: '', options_type_id: AskIt::OptionsType.multi_choices)
    option_b = create_option(text: nil, options_type_id: AskIt::OptionsType.multi_choices)

    option_c = create_option(text: '', options_type_id: AskIt::OptionsType.single_choice)
    option_d = create_option(text: nil, options_type_id: AskIt::OptionsType.single_choice)

    option_e = create_option(text: '', options_type_id: AskIt::OptionsType.multi_choices_with_text)
    option_f = create_option(text: nil, options_type_id: AskIt::OptionsType.multi_choices_with_text)

    option_g = create_option(text: '', options_type_id: AskIt::OptionsType.single_choice_with_text)
    option_h = create_option(text: nil, options_type_id: AskIt::OptionsType.single_choice_with_text)

    option_i = create_option(text: '', options_type_id: AskIt::OptionsType.multi_choices_with_number)
    option_j = create_option(text: nil, options_type_id: AskIt::OptionsType.multi_choices_with_number)

    option_k = create_option(text: '', options_type_id: AskIt::OptionsType.single_choice_with_number)
    option_l = create_option(text: nil, options_type_id: AskIt::OptionsType.single_choice_with_number)

    should_not_be_persisted option_a
    should_not_be_persisted option_b

    should_not_be_persisted option_c
    should_not_be_persisted option_d

    should_not_be_persisted option_e
    should_not_be_persisted option_f

    should_not_be_persisted option_g
    should_not_be_persisted option_h

    should_not_be_persisted option_i
    should_not_be_persisted option_j

    should_not_be_persisted option_k
    should_not_be_persisted option_l
  end

  test 'should be true if option A is correct and option B incorrect' do
    option_a = create_option(correct: false)
    option_b = create_option(correct: true)

    should_be_false option_a.correct?
    should_be_true  option_b.correct?
  end

  # correct => default weight is 1
  # incorrect => default weight is 0
  test 'should be true weights are synchronized with the correct flag' do
    option_a = create_option(correct: false)
    option_b = create_option(correct: true)
    option_c = create_option(correct: true, weight: 5)

    should_be_true(option_a.weight.zero?)
    should_be_true(option_b.weight == 1)
    should_be_true(option_c.weight == 5)
  end
end
