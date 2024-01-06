class ApplicationController < ActionController::Base
    before_action :authenticate_user
    around_action :handle_exceptions
    skip_before_action :verify_authenticity_token

    include ResponseConcern
    
    def authenticate_user
		return build_json_response(403, false, "Authorization Header not present") if request.headers['Authorization'].blank?
        token = request.headers['Authorization'].gsub('Bearer ', '')
		raise Api::V1::Services::Errors::UnAuthorizedRequest, error_message unless token.present?
		@jwt_payload = JsonWebToken.decode(token)
		raise Api::V1::Services::Errors::CustomError, "Invalid Token" if @jwt_payload.blank?
		@current_user ||= User.find_by_id(@jwt_payload[:id])
    end

    def handle_exceptions
		yield
		rescue ActiveRecord::RecordNotFound => e
			respond_with_error(e, :not_found)
		rescue ActiveRecord::RecordInvalid => e
			respond_with_error(StandardError.new(e.record.errors.full_messages.join(", ")))
		rescue Api::V1::Services::Errors::CustomError => e
			respond_with_error(e, e.error_code, e.message)
		rescue Api::V1::Services::Errors::UnAuthorizedRequest => e
			respond_with_error(e, :unauthorized)
		rescue StandardError => e
			respond_with_error(e, :internal_server_error, "Something Went Wrong")
			Rails.logger.error e.to_s
		return if e.instance_of?(NilClass)
 	end

	 def respond_with_error(error, status = :bad_request, error_message = error.message)
		response = { message: error_message }
		render json: response, status:
	end
end
