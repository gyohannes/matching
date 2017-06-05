require 'test_helper'

class ProgramChoicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @program_choice = program_choices(:one)
  end

  test "should get index" do
    get program_choices_url
    assert_response :success
  end

  test "should get new" do
    get new_program_choice_url
    assert_response :success
  end

  test "should create program_choice" do
    assert_difference('ProgramChoice.count') do
      post program_choices_url, params: { program_choice: { applicant_id: @program_choice.applicant_id, choice_number: @program_choice.choice_number, program_id: @program_choice.program_id } }
    end

    assert_redirected_to program_choice_url(ProgramChoice.last)
  end

  test "should show program_choice" do
    get program_choice_url(@program_choice)
    assert_response :success
  end

  test "should get edit" do
    get edit_program_choice_url(@program_choice)
    assert_response :success
  end

  test "should update program_choice" do
    patch program_choice_url(@program_choice), params: { program_choice: { applicant_id: @program_choice.applicant_id, choice_number: @program_choice.choice_number, program_id: @program_choice.program_id } }
    assert_redirected_to program_choice_url(@program_choice)
  end

  test "should destroy program_choice" do
    assert_difference('ProgramChoice.count', -1) do
      delete program_choice_url(@program_choice)
    end

    assert_redirected_to program_choices_url
  end
end
