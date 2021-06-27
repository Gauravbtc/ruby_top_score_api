class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  def parameter_missing?(check_parameters = [], parameters = {})
    missing_params = []
    missing_params << check_parameters.select { |p| parameters[p].to_s.strip.blank? }
    if missing_params.flatten!.present?
      raise ArgumentError, "Check parameters"
    end
  end
end
