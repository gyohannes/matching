require 'test_helper'

class UniversityChoicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @university_choice = university_choices(:one)
  end

  test "should get index" do
    get university_choices_url
    assert_response :success
  end

  test "should get new" do
    get new_university_choice_url
    assert_response :success
  end

  test "should create university_choice" do
    assert_difference('UniversityChoice.count') do
      post university_choices_url, params: { university_choice: { choice_number: @university_choice.choice_number, program_choice_id: @university_choice.program_choice_id, university_id: @university_choice.university_id } }
    end

    assert_redirected_to university_choice_url(UniversityChoice.last)
  end

  test "should show university_choice" do
    get university_choice_url(@university_choice)
    assert_response :success
  end

  test "should get edit" do
    get edit_university_choice_url(@university_choice)
    assert_response :success
  end

  test "should update university_choice" do
    patch university_choice_url(@university_choice), params: { university_choice: { choice_number: @university_choice.choice_number, program_choice_id: @university_choice.program_choice_id, university_id: @university_choice.university_id } }
    assert_redirected_to university_choice_url(@university_choice)
  end

  test "should destroy university_choice" do
    assert_difference('UniversityChoice.count', -1) do
      delete university_choice_url(@university_choice)
    end

    assert_redirected_to university_choices_url
  end
end
