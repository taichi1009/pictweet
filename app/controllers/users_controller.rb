class UsersController < ApplicationController
  def show
    @nickname = current_user.nickname
    #whereメソッドの引数を(カラム名: そのカラムの値)とすることでその条件に当てはまるレコードを全て取得することができます。
    # @tweets = Tweet.where(user_id: current_user.id).page(params[:page]).per(5).order("created_at DESC")
    @tweets = current_user.tweets.page(params[:page]).per(5).order("created_at DESC")
  end
end
