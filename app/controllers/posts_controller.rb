class PostsController < ApplicationController

  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

  def index
    # "Post.all"は全てのPostデータを取り出すコード
    # "order(created_at: :desc)"は出力される順番を新規が上部になるよう変更するコード
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    # 投稿データーを取得するコード
    @post = Post.find_by(id: params[:id])
    @user = @post.user

    @comments = Comment.all
  end

  def new
  end

  def create
    # "content"が入力データであるインスタンスを作成している
    @post = Post.new(
      title: params[:title],
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
    @post.title = params[:title]
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

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/")
    end
  end

end
