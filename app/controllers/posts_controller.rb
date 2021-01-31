class PostsController < ApplicationController
  def index 
    @posts = Post.all
  end

  def new 
    @post = Post.new
  end

  def show 
    @post = Post.find params[:id] 
    @comment = Comment.new
  end

  def edit 
    @post = Post.find params[:id]
  end

  def create 
    # Whitelisting the params 
    post_params = params.require(:post).permit(:title, :body) 
    @post = Post.new post_params
    if @post.save 
      # render plain: "You've created a new product."
      flash[:notice] = "Post created successfully"
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def update 
    post_params = params.require(:post).permit(:title, :body) 
    @post = Post.find params[:id] 
    if @post.update post_params 
      flash[:notice] = "Post was successfully updated"
      redirect_to post_path
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find params[:id] 
    @post.destroy
    redirect_to posts_path 
  end

end
