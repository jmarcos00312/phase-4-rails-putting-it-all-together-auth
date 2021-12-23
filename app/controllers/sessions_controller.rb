class SessionsController < ApplicationController
  #   GET /me
  # returns the first user when the first user is logged in
  # returns the second user when the second user is logged in
  #    creates a new recipe in the database
  skip_before_action :authorized, only: [:create]

  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      #  sets the user ID in the session
      session[:user_id] = user.id
      render json: user, status: :created
    else
      #   with invalid password
      #         returns a 401 (Unauthorized) status code (FAILED - 1)
      #   with invalid username
      #         returns an array of error messages in the body (FAILED - 2)
      #         returns a 401 (Unauthorized) status code (FAILED - 3)
      render json: {
               errors: ['Invalid username or password'],
             },
             status: :unauthorized
    end
  end

  def destroy
    session.delete :user_id
    head :no_content
  end
end
