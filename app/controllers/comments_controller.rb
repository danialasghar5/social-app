class CommentsController < ApplicationController
  before_action :set_post, only: [:new, :create, :destroy]
  before_action :set_comment, only: [:destroy]

  def index
    @comments = Comment.all
  end

  def new
    @comment = @post.comments.new(@post)
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_to post_path(@post)
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post), :notice => "comment successfully destroy!"
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
    authorize @comment
  end
end
