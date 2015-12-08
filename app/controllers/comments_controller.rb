class CommentsController < ApplicationController

  def new
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:review_id])
    @comment = Comment.new
  end

  def create
    p params
    @review = Review.find(params[:review_id])
    @movie = Movie.find(params[:movie_id])
    @comment = @review.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to movie_review_path(@movie, @review)
    else
      render 'new'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end