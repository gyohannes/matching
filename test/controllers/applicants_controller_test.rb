require 'test_helper'

class ApplicantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @applicant = applicants(:one)
  end

  test "should get index" do
    get applicants_url
    assert_response :success
  end

  test "should get new" do
    get new_applicant_url
    assert_response :success
  end

  test "should create applicant" do
    assert_difference('Applicant.count') do
      post applicants_url, params: { applicant: { date_of_birth: @applicant.date_of_birth, email: @applicant.email, father_name: @applicant.father_name, first_name: @applicant.first_name, gender: @applicant.gender, grand_father_name: @applicant.grand_father_name } }
    end

    assert_redirected_to applicant_url(Applicant.last)
  end

  test "should show applicant" do
    get applicant_url(@applicant)
    assert_response :success
  end

  test "should get edit" do
    get edit_applicant_url(@applicant)
    assert_response :success
  end

  test "should update applicant" do
    patch applicant_url(@applicant), params: { applicant: { date_of_birth: @applicant.date_of_birth, email: @applicant.email, father_name: @applicant.father_name, first_name: @applicant.first_name, gender: @applicant.gender, grand_father_name: @applicant.grand_father_name } }
    assert_redirected_to applicant_url(@applicant)
  end

  test "should destroy applicant" do
    assert_difference('Applicant.count', -1) do
      delete applicant_url(@applicant)
    end

    assert_redirected_to applicants_url
  end
end
