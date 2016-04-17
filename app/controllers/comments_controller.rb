class CommentsController < ApplicationController
  def create
    @post = Post.find(params["id"])
    @comments = @post.comments.create(content: params["content"],
                                        post_id: @post.id,
                                        user_id: current_user.id,
                                        mood_at_time: current_user.mood,
                                        top_comment: false,
                                        bad_comment: false)
    render "posts/show.json.jbuilder", status: :created
  end

  def choose_top_comment
    @comment = Comment.find(params["id"])
    @user = User.find_by(id: @comment.user_id)
    @post = Post.find_by(id: @comment.post_id)
    if !@post.point_given && !@post.point_taken
      @comment.update(top_comment: true)
      @user.update(points: (@user.points += 1))
      @post.update(point_given: true)
      @post.update(active: false)
      render "posts/show.json.jbuilder", status: :ok
    elsif !@post.point_given
      render json: { message: "COMMENT IS ALREADY 'TOP COMMENT'"},
            status: :unauthorized
    else
      render json: { message: "'BAD COMMENT' CANNOT BE 'TOP COMMENT'"},
            status: :unauthorized
    end
  end

  def choose_bad_comment
    @comment = Comment.find(params["id"])
    @user = User.find_by(id: @comment.user_id)
    @post = Post.find_by(id: @comment.post_id)
    if !@post.point_given && !@post.point_taken
      @comment.update(bad_comment: true)
      @user.update(points: (@user.points -= 1))
      @post.update(point_taken: true)
      render "posts/show.json.jbuilder", status: :ok
    elsif !@post.point_given
      render json: { message: "'TOP COMMENT' CANNOT BE 'BAD COMMENT'"},
            status: :unauthorized
    else
      render json: { message: "COMMENT IS ALREADY A 'BAD COMMENT'"},
            status: :unauthorized
    end
  end

  def edit
    @comment = Comment.find(params["id"])
    render :edit, locals: {comment: @comment}
  end

  def update
    @comment = Comment.find(params["id"])
    @comment.update(content: params["content"])
    render "posts/show.json.jbuilder", status: :ok
  end

  def delete
    @comment = Comment.find(params["id"])
    post_id = @comment.post_id
    @comment.destroy
    render "posts/show.json.jbuilder", status: :ok
  end
end
