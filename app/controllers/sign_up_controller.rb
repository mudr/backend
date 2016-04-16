class SignUpController < ApplicationController
  skip_before_filter  :verify_authenticity_token, only: [:create, :login]

  def create
    @user = User.new(username: params['username'],
                     avatar: params['avatar'],
                     email: params['email'],
                     password: params['password'])
    @user.ensure_auth_token
    if @user.save
      render json: { user: @user.as_json(only: [:username, :avatar, :email, :auth_token]) },
                     status: :created
    else
      render json: { errors: @user.errors.full_messages },
                     status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find_by(username: params["username"])
    if @user.authenticate(params["password"])
      @user.destroy
        render plain: "USER DESTROYED", 
        status: :accepted
    else
      render json: { error: "UNAUTHORIZED" },
        status: :unauthorized
    end
  end
  
end
