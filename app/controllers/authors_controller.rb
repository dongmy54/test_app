class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  # GET /authors
  # GET /authors.json
  def index
    @authors = Author.all.limit(5)
  end

  # GET /authors/1
  # GET /authors/1.json
  def show
  end

  # GET /authors/new
  def new
    @author = Author.new
  end

  # GET /authors/1/edit
  def edit
  end

  # POST /authors
  # POST /authors.json
  def create
    @author = Author.new(author_params)

    respond_to do |format|
      if @author.save
        format.html { redirect_to @author, notice: 'Author was successfully created.' }
        format.json { render :show, status: :created, location: @author }
      else
        format.html { render :new }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authors/1
  # PATCH/PUT /authors/1.json
  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to @author, notice: 'Author was successfully updated.' }
        format.json { render :show, status: :ok, location: @author }
      else
        format.html { render :edit }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authors/1
  # DELETE /authors/1.json
  def destroy
    @author.destroy
    respond_to do |format|
      format.html { redirect_to authors_url, notice: 'Author was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # 分享列表
  def home_list
  end

  ############################### 片段缓存开始 #############################
  # 不指定任何
  def frag_test
  end

  # 对象
  def frag_test1
    @author = Author.first
  end

  # 对象数组
  def frag_test2
    @author  = Author.first
    @article = @author.articles.first
  end

  # 过期时间
  def frag_test3
  end
  
  # 对象集合
  def frag_test4
    @authors = Author.all.limit(10)
  end
  ############################### 片段缓存结束 #############################

  
  ############################### 俄罗斯套娃开始 #############################
  # 不使用嵌套缓存问题
  # 1. 外层对象更新 所有缓存都失效
  def russia_cache
    @authors = Author.all.limit(10)
  end

  # 俄罗斯套娃缓存
  # 特别注意 内部更新需要 touch外部更新 以便获取最新缓存
  def russia_cache1
    @authors = Author.all.limit(10)
  end

  ############################### 俄罗斯套娃结束 #############################

  ############################### sql缓存开始 #############################
  # sql缓存
  def sql_cache
    # 第一次从数据库中取
    @authors = Author.all
    # Author Load (0.5ms)  SELECT "authors".* FROM "authors"

    # 第二次从内存中取
    hu = Author.all
    # CACHE (0.0ms)  SELECT "authors".* FROM "authors"
  end

  ############################### sql缓存结束 #############################

  ############################### 条件get开始 #############################
  # 条件get
  def condition_get
    @author = Author.find(params[:id])

    # 自定义etag 和 last_modified
    if stale?(last_modified: @author.updated_at.utc, etag: @author.cache_key)
      respond_to do |format|
        format.html {render :condition_get}
      end
    end
  end

  def condition_get1
    @author = Author.find(params[:id])

    # 给对象
    if stale?(@author)
      respond_to do |format|
        format.html {render :condition_get1}
      end
    end
  end

  def condition_get2
    @author = Author.find(params[:id])
    fresh_when @author # 简写 适用于不区分format的情况
  end
  ############################### 条件get结束 #############################

  ############################### 显示依赖开始 #############################
  # helper中渲染不同模版
  def explicit_dependence
    @author = Author.find(params[:id])
  end

  # 依赖helper更新
  def external_dependence
    @author = Author.find(params[:id])
  end
  ############################### 显示依赖结束 #############################

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def author_params
      params.require(:author).permit(:name, :age)
    end
end
