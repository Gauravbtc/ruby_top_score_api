module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern
  included do
    ## pass only permitted Parameters only
    ActionController::Parameters.action_on_unpermitted_parameters = :raise
    # Raised when Active Record cannot find a record by given id or set of ids.
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ success: false, message: e.message, status_code: 404, data: {} }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ success: false, message: e.message , data: {} }, :unprocessable_entity)
    end

    rescue_from ArgumentError do |e|
      json_response({ success: false, message: e.message, status_code: 422, data: {}  }, :unprocessable_entity)
    end

    rescue_from ActionController::UnpermittedParameters do |e|
      json_response({ success: false , message: e.message, status_code: 400, data: {}  }, :bad_request )
    end

  end
end