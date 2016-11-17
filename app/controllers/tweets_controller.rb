class TweetsController < ApplicationController

  before_action :move_to_index, except: :index
  def index
    @tweets = Tweet.includes(:user).page(params[:page]).per(5).order("created_at DESC")
  end

  def new
    @tweet = Tweet.new
  end

  def create
    Tweet.create(tweet_params)
    # redirect_to root_path
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    #削除を行えるのは、そのツイートを投稿したユーザーのみです。そのため、別のユーザーが削除をできないように条件をつける必要があります。
    @tweet.destroy if @tweet.user_id == current_user.id
    # redirect_to root_path
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])
    @tweet.update(tweet_params) if @tweet.user_id == current_user.id
    #updateメソッドの引数はtweet_paramsとしていますが、これはどういうことでしょうか。tweet_paramsはストロングパラメーターで、つまりはparamsから:imageと:textというキーだけを残したハッシュとなっています。また本来、updateメソッドの引数は、更新したいカラム名: 更新する値とハッシュの形式を取ります。この時、ビュー側で決定するパラメーターのキーの名前を、更新するテーブルのカラム名と一致させておくことで、tweet_paramsとしてまとめるだけでupdateメソッドの引数にすることができます。
  end

  private
  def tweet_params
    params.require(:tweet).permit(:text, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
