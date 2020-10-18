class Admin::ArticlesController < Admin::ApplicationController
  load_and_authorize_resource find_by: :uid, id_param: :uid

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @article.author = current_user
    if @article.save
      redirect_to [:admin, @article], notice: 'Article was successfully created.'
    else
      byebug
      render :new
    end
  end

  def update
    if @article.update(article_params)
      redirect_to [:admin, @article], notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def publish
    @article.update(published: params[:published])
    head :ok
  end

  def destroy
    @article.destroy
    redirect_to admin_articles_url, notice: 'Article was successfully destroyed.'
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :published_at, :pinned)
  end
end
