class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.new
  end

  def show
  end

  def create
    @post = current_user.posts.build(post_params)
     if @post.save
      flash[:notice] = "Post Successfully Created."
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    authorize @post
    if @post.update(post_params)
      flash[:notice] = 'Post updated!'
      redirect_to root_path
    else
      render "edit"
    end
  end

  def destroy
    authorize @post
    @post.destroy
    redirect_to posts_path, :notice => "Post successfully destroy!"
  end

private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
