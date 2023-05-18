class CommentsController < ApplicationController
  def create
    comment_params = params.require(:comment).permit(:content, :parent_id, :batch_id)
    @comment = Comment.new comment_params
    @comment.user = current_user
    return redirect_to batch_detail_path(@comment.batch_id) if @comment.save
    redirect_to batch_detail_path(@comment.batch_id)
  end
end
