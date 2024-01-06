class Api::V1::AuthenticationController < ApplicationController

  skip_before_action :authenticate_user, only: [:sign_up, :login]

  def sign_up
    user = User.create(user_params)
    if user.valid?
      build_json_response(200,true,"User Created Successfully. Please Login")
    else
      build_json_response(200,true,"Invalid Credentials")
    end
  end

  def login
    user = User.find_by(email: user_params[:email])
    raise ActiveRecord::RecordNotFound if user.nil?
    if user && user.authenticate(user_params[:password])
      payload = {id: user.id}
      token = JsonWebToken.encode(payload)
      user.user_tokens.create(token: token,token_expire: Time.now + 24.hours)
      build_json_response(200,true,"Logged in Successfully",token: token)
    else  
      build_json_response(200,true,"invalid Credentials")
    end
  end

  def logout
    status = @current_user.user_tokens.destroy_all
    build_json_response(200, true, "User Logout Succcessfully") if status.present?
  end

  private

  def user_params
    params.permit(:email, :password)
  end
  
end
