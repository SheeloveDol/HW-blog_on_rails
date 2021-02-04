class PostsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  before_action :set_post, only: [:show, :edit, :update, :destroy]

  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index 
    @posts = Post.all
  end

  def new 
    @post = Post.new
  end

  def show  
    @comment = Comment.new
    # @comment.user = @post.comments.order(created_at: :desc) 
    @comments = @post.comments.all.order(created_at: :desc)
  end

  def edit 
  end

  def create 
    # Whitelisting the params 
    @post = Post.new post_params_whitelisting #<--refactored
    @post.user = current_user

    if @post.save 
      flash[:notice] = "Post created successfully"
      redirect_to post_path(@post_id)
    else
      render :new
    end

  end

  def update 
    if @post.update post_params_whitelisting #<--refactored
      flash[:notice] = "Post was successfully updated"
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path 
  end


  private 
  
  def set_post
    @post = Post.find params[:id]
  end

  def post_params_whitelisting
    post_params = params.require(:post).permit(:title, :body) 
  end

  def authorize_user!
    redirect_to root_path, alert: "Access Denied" unless can?(:crud, @post)
  end

end
