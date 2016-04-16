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
