class SignUpController < ApplicationController
  skip_before_filter  :verify_authenticity_token, only: [:create, :login]

  def create
    @user = User.new(username: params['username'],
                     avatar: params['avatar'],
                     email: params['email'],
                     mood: params['mood'],
                     password: params['password'],
                     points: 0,
                     enabled: true)
    @user.ensure_auth_token
    if @user.save
      render "create.json.jbuilder", status: :created
    else
      render json: { errors: @user.errors.full_messages },
                     status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params["id"])
    render :edit, locals: {user: @user}
  end

  def update
    right_now = DateTime.now
    @user = User.find(params["id"])
    @user.update(username: params["title"],
                email: params["email"],
                password: params["password"],
                avatar: params["content"],
                mood: params["mood"])
    @post.updated_at = right_now
    render "create.json.jbuilder", status: :ok
  end

  def login
    @user = User.find_by!(username: params["username"])
    set_disable
    if @user.authenticate(params["password"]) && @user.enabled
      render json: { user: @user.as_json(only: [:username, :auth_token]) },
          status: :ok
    else
      render json: { message: "INVALID EMAIL OR PASSWORD."},
          status: :unauthorized
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

  def set_disable
    @user = User.find(params["id"])
    if @user.points < -3
      @user.enabled = false
    end
  end
end
