class PostsController < ApplicationController

  before_action :authenticate_user

  def index
    # "Post.all"は全てのPostデータを取り出すコード
    # "order(created_at: :desc)"は出力される順番を新規が上部になるよう変更するコード
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    # 投稿データーを取得するコード
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
  end

  def new
  end

  def create
    # "content"が入力データであるインスタンスを作成している
    @post = Post.new(
      content: params[:content],
      user_id: @current_user.id
    )
    @post.save
      flash[:notice] = "投稿を作成しました"
    # データ転送後に移動するページ
      redirect_to("/")
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      redirect_to("/")
    else
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to("/")
  end

end
