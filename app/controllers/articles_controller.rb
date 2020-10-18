class ArticlesController < ApplicationController
  def index
    @articles = Article.published_in_the_past.ordered
  end

  def show
    @article = Article.published_in_the_past.find_by(uid: params[:uid])
  end
end
