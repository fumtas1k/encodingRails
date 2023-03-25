class ApplicationController < ActionController::API
  include ActionController::ParameterEncoding
  setup_param_encode
end
