class PostsController < ApplicationController

  def index
    @posts = Post.includes(:user)
  end

  def new
    @post = Post.new # Postクラスの空のインスタンスを生成して@postに代入して！
  end

  def create
    Post.create(post_params)  # Postクラスのテーブルにレコードを追加して！
    redirect_to root_path # createできたら大元のパスに戻ろう!
  end
  
  def show
    @post = Post.find(params[:id]) # ブラウザからのparams[:id]番号の情報をテーブルから見つけて@postに代入！
  end

  def edit
    @post = Post.find(params[:id]) # ブラウザからのparams[:id]番号の情報をテーブルから見つけて@postに代入！
  end

  def update
    post = Post.find(params[:id]) # ブラウザからのparams[:id]番号の情報をテーブルから見つけて@postに代入！ 
    post.update(post_params) # updateされた情報もpost_params制限をかけてテーブルへ！
    redirect_to post_path(post.id) # updateできたらid番号のpostパスに戻ろう!
  end

  def destroy
    post =  Post.find(params[:id])
    post.destroy
    redirect_to root_path
  end

  private # クラス外から呼び出されない
  def post_params # このクラス内のみのメソッドを作成！
    params.require(:post).permit(:title, :content).merge(user_id: current_user.id)  # :title, :contentのみOK！
  end

end
