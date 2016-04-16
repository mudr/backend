class CommentsController < ApplicationController
  def create
    @post = Post.find(params["id"])
    new_comment = @post.comments.create(content: params["body"],
                                        post_id: @post.id,
                                        user_id: current_user.id,
                                        mood_at_time: current_user.mood,
                                        top_comment: false,
                                        bad_comment: false)
    redirect_to posts_display_path(params["id"])
  end

  def choose_top_comment
    @comment = Comment.find(params["id"])
    user = User.find_by(id: @comment.user_id)
    post = Post.find_by(id: @comment.post_id)
    @comment.top_comment = true
    user.points += 1
    post.point_given = true
    post.active = false
  end

  def choose_bad_comment
    @comment = Comment.find(params["id"])
    user = User.find_by(id: @comment.user_id)
    post = Post.find_by(id: @comment.post_id)
    @comment.bad_comment = true
    user.points -= 1
    post.point_given = true
  end

  def edit
    @comment = Comment.find(params["id"])
    render :edit, locals: {comment: @comment}
  end

  def update
    @comment = Comment.find(params["id"])
    @comment.update(content: params["content"])
    redirect_to posts_display_path(params["post_id"])
  end

  def delete
    @comment = Comment.find(params["id"])
    post_id = @comment.post_id
    @comment.destroy
    redirect_to posts_display_path(post_id)
  end
end
