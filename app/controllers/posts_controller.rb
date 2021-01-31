class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index 
    @posts = Post.all
  end

  def new 
    @post = Post.new
  end

  def show  
    @comment = Comment.new
  end

  def edit 
  end

  def create 
    # Whitelisting the params 
    @post = Post.new post_params_whitelisting #<--refactored
    if @post.save 
      # render plain: "You've created a new product."
      flash[:notice] = "Post created successfully"
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def update 
    if @post.update post_params_whitelisting #<--refactored
      flash[:notice] = "Post was successfully updated"
      redirect_to post_path
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

end
