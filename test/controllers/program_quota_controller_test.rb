require 'test_helper'

class ProgramQuotaControllerTest < ActionDispatch::IntegrationTest
  setup do
    @program_quotum = program_quota(:one)
  end

  test "should get index" do
    get program_quota_url
    assert_response :success
  end

  test "should get new" do
    get new_program_quotum_url
    assert_response :success
  end

  test "should create program_quotum" do
    assert_difference('ProgramQuotum.count') do
      post program_quota_url, params: { program_quotum: { program_id: @program_quotum.program_id, quota_number: @program_quotum.quota_number, university_id: @program_quotum.university_id } }
    end

    assert_redirected_to program_quotum_url(ProgramQuotum.last)
  end

  test "should show program_quotum" do
    get program_quotum_url(@program_quotum)
    assert_response :success
  end

  test "should get edit" do
    get edit_program_quotum_url(@program_quotum)
    assert_response :success
  end

  test "should update program_quotum" do
    patch program_quotum_url(@program_quotum), params: { program_quotum: { program_id: @program_quotum.program_id, quota_number: @program_quotum.quota_number, university_id: @program_quotum.university_id } }
    assert_redirected_to program_quotum_url(@program_quotum)
  end

  test "should destroy program_quotum" do
    assert_difference('ProgramQuotum.count', -1) do
      delete program_quotum_url(@program_quotum)
    end

    assert_redirected_to program_quota_url
  end
end
