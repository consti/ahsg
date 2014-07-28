class CommentsController < ApplicationController

  def index
    @comments = Comment.all
  end

  def create
    @comment = current_user.authored_comments.new(comment_params)
    if @comment.save
      redirect_to @comment.commentable, notice: 'Comment was successfully created.'
    else
      redirect_to @comment.commentable, notice: 'Missing text.'
    end
  end

  def destroy
    current_user.authored_comments.find(params[:id]).destroy
    redirect_to comments_url, notice: 'Comment was successfully destroyed.'
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:text, :commentable_type, :commentable_id)
    end
end
