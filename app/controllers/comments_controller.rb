class CommentsController < ApplicationController
  
  before_action :authenticate_user!

  def create 
    @post = Post.find params[:post_id]
    @comment = Comment.new params.require(:comment).permit(:body)
    @comment.post = @post
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def destroy 
    @post = Post.find params[:post_id] 
    @comment = Comment.find params[:id] 
    @comment.destroy 
    redirect_to post_path(@post), notice: "Comment Deleted"
  end


  private 



  def authorize_user!
    redirect_to root_path, alert: "Access Denied" unless can?(:crud, @comment)
  end
end
