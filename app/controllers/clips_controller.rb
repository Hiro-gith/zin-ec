class ClipsController < ApplicationController
  
  def create
    @user_id = current_user.id
    @item_id = Item.find(params[:id]).id
    @clip = Clip.new(item_id: @item_id, user_id: @user_id)
    @item = Item.find(params[:id])
    
    if current_user.clips.exists?(item_id: "#{params[:id]}")
      old_clip = current_user.clips.find_by(item_id: "#{params[:id]}")
      old_clip.destroy
    end
    
    if @clip.save
      redirect_to item_path(@item)
      flash[:success] = "商品がお気に入り登録されました"
    end

  end

  def destroy
    @clip = Clip.find_by(item_id: params[:item_id])
    if @clip.destroy
      redirect_to clips_path
      flash[:success] = "お気に入り登録が削除されました"
    end
  end
end
