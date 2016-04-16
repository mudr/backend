class PostsController < ApplicationController
  before_action :authenticate!, only: [:new, :create, :edit, :update, :delete]

  def index
    @posts = Post.all
    @users = User.all
    render "index.json.jbuilder", status: :ok
  end

  def new
    render :new
  end

  def create
    @post = current_user.posts.create(title: params["title"],
                                      content: params["content"],
                                      mood_at_time: current_user.mood,
                                      active: true)
    if @post.save 
      render "create.json.jbuilder", status: :created
    else
      render json: { errors: @post.errors.full_messages },
          status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params["id"])
    render :edit, locals: {post: @post}
  end

  def update
    right_now = DateTime.now
    @post = Post.find(params["id"])
    if @post.active
      @post.update(title: params["title"],
                  content: params["content"],
                  active: params["active"])
      @post.updated_at = right_now
      render "create.json.jbuilder", status: :accepted
    else
      render json: { message: "You are not allowed to update an inactive post."},
          status: :unauthorized
    end
  end

  def show
    @post = Post.find(params["id"])
    @comments = @post.comments.all
    render "show.json.jbuilder", status: :ok
  end

  def delete
    @post = Post.find(params["id"])
    comments = Comment.where(post_id: @post.id)
    comments.each do |comment|
      comment.destroy
    end
    @post.destroy
  end
end
