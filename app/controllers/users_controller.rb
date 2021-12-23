class UsersController < ApplicationController
  # with matching password confirmation
  skip_before_action :authorized, only: :create

  #     GET /me

  # returns the first user when the first user is logged in
  # returns the second user when the second user is logged in
  # returns a 401 unauthorized response when no user is logged in
  def me
    user = User.find_by(id: session[:user_id])
    render json: user
  end

  def create
    #   creates a new user (FAILED - 1)
    #   saves the password as password_digest to allow authentication (FAILED - 2)
    #   saves the user id in the session (FAILED - 3)
    #   returns the user as JSON (FAILED - 4)
    #   returns a 201 (Created) HTTP status code (FAILED - 5)
    user = User.create(user_params)
    if user.valid?
      session[:user_id] = user.id
      render json: user, status: :created
    else
      #   with no matching password confirmation
      #           returns an array of error messages in the body (FAILED - 1)
      #           returns a 422 (Unprocessable Entity) HTTP status code (FAILED - 2)
      render json: {
               errors: user.errors.full_messages,
             },
             #      with invalid data
             #   returns an array of error messages in the body (FAILED - 3)
             #   returns a 422 unprocessable entity response (FAILED - 4)
             status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:username, :password, :password_confirmation)
  end
end
