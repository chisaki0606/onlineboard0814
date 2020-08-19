class CommentsController < ApplicationController
  def index
    @comments = Comment.all.order(created_at: :desc)
  end

  def create
    @comment = Comment.new(user_content: params[:user_content])            
    @comment.save
    redirect_to("/comments/index")
  end

end
