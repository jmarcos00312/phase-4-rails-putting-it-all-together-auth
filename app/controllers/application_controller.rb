class ApplicationController < ActionController::API
  include ActionController::Cookies

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid
  before_action :authorized

  private

  def render_not_found(exception)
    render json: { errors: "#{exception.model} not found" }, status: :not_found
  end

  def render_invalid(invalid)
    render json: {
             errors: invalid.record.errors.full_messages,
           },
           status: :unprocessable_entity
  end

  def authorized
    @current_user = User.find_by(id: session[:user_id])

    unless session.include? :user_id
      render json: {
               errors: ['Invalid username or password'],
             },
             status: :unauthorized
    end
  end
end
