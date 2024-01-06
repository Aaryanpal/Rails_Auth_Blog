module ResponseConcern

	def build_response(status, success, message, data = nil)
		response = { status: status, success: success, message: message}
		response.merge!(data) if data.present? && (data.is_a? Hash)
		response
	end
	
	def build_json_response(status, success, message, data = nil)
		return render json: build_response(status, success, message, data), status: status
	end
    
end