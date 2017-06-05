json.extract! exam_result, :id, :exam_id, :program_id, :result, :created_at, :updated_at
json.url exam_result_url(exam_result, format: :json)
