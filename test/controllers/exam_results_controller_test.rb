require 'test_helper'

class ExamResultsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exam_result = exam_results(:one)
  end

  test "should get index" do
    get exam_results_url
    assert_response :success
  end

  test "should get new" do
    get new_exam_result_url
    assert_response :success
  end

  test "should create exam_result" do
    assert_difference('ExamResult.count') do
      post exam_results_url, params: { exam_result: { exam_id: @exam_result.exam_id, program_id: @exam_result.program_id, result: @exam_result.result } }
    end

    assert_redirected_to exam_result_url(ExamResult.last)
  end

  test "should show exam_result" do
    get exam_result_url(@exam_result)
    assert_response :success
  end

  test "should get edit" do
    get edit_exam_result_url(@exam_result)
    assert_response :success
  end

  test "should update exam_result" do
    patch exam_result_url(@exam_result), params: { exam_result: { exam_id: @exam_result.exam_id, program_id: @exam_result.program_id, result: @exam_result.result } }
    assert_redirected_to exam_result_url(@exam_result)
  end

  test "should destroy exam_result" do
    assert_difference('ExamResult.count', -1) do
      delete exam_result_url(@exam_result)
    end

    assert_redirected_to exam_results_url
  end
end
