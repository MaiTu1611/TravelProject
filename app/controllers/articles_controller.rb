class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /articles
  # GET /articles.json
  def index
    @user = current_user
    if !@user.has_role?
      redirect_to questions_path
    end
    
    @@page_article  = params[:page_article]
    @@page_question = params[:page_question]
    @@page_user     = params[:page_user]
    if params[:search]
      @articles     = Article.search(params[:search]).page(@@page_article).per(3)
      @questions    = Question.search(params[:search]).page(@@page_question).per(3)
      @users        = User.search(params[:search]).page(@@page_user).per(3).where.not(id: @user.id)
    else
      @articles     = Article.page(@@page_article).per(3)
      @questions    = Question.page(@@page_question).per(3)
      @users        = User.page(@@page_user).per(3).where.not(id: @user.id)
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    byebug
    @article = Article.new(article_params)

    # Check file before get
    if params[:article][:file] != nil
      # Get file attached
      file_upload = params[:article][:file]
      # Write file to public/files with original file name
      File.open(Rails.root.join('public','files', file_upload.original_filename), "wb") do |file| 
         file.write(file_upload.read)
      end
      # Set name file to create to DB
      @article.file = file_upload.original_filename
    end
    byebug

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    byebug
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy

    # Check destroy last record
    @articles = Article.page(@@page_article).per(3)
    # if destroy last record
    if @articles.length == 0 
      page_article = (page_article.to_i - 1) > 1 ? page_article.to_i - 1 : 1  
      redirect_to articles_path(page_article: page_article)
    end

    respond_to do |format|
      # Using ajax when delete article
      format.js {}
      # format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      # format.json { head :no_content }
    end
  end

  # Function to get file when click link
  # File downloaded flowing id
  def downloadFile
    article = set_article
    send_file Rails.root.join('public', 'files', article.file)
    byebug
    # redirect_to articles_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      byebug
      params.require(:article).permit(:title, :post, :file, :image)
    end
end
