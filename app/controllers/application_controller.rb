class ApplicationController < ActionController::API
  include ActionController::Cookies

  before_action :unauthorized_error_message
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_error_message


  private 

  def unauthorized_error_message
    render json: { errors: [ 'Not authorized' ] }, status: :unauthorized unless session.include? :user_id 
  end

  def unprocessable_entity_error_message(invalid)
    render json: { errors: [invalid.record.errors.full_messages] }, status: :unprocessable_entity
  end

end
