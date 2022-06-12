class Public::WeightsController < ApplicationController

  def index
    @weights = Weight.where(end_user_id: current_end_user.id)
    @weight = Weight.new
    @graph = Weight.where(end_user_id: current_end_user.id).pluck(:record_day, :value)
  end

  def create
    @weight = Weight.new(weight_params)
    if @weight.save
      flash[:notice] = "体重を登録しました！"
      @weights = Weight.where(end_user_id: current_end_user.id)
      redirect_to action: 'index'
    else
      @weights = Weight.where(end_user_id: current_end_user.id)
      render :index
    end
  end

  def edit
    @weight = Weight.find(params[:id])
  end

  def update
    @weight = Weight.find(params[:id])
    if @weight.update(weight_params)
      flash[:notice] = "体重を更新しました。"
      @weights = Weight.where(end_user_id: current_end_user.id)
      redirect_to weights_path
    else
      flash[:alret] = "更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @weight = Weight.find(params[:id])
    if @weight.destroy
      flash[:notice] = "体重を削除しました"
      @weights = Weight.where(end_user_id: current_end_user.id)
      redirect_to weights_path
    else
      render :index
    end
  end


  private

  def weight_params
    params.require(:weight)
    .permit(:value, :record_day)
    .merge(end_user_id: current_end_user.id)
  end


end
