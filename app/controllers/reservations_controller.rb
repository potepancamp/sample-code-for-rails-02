class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_own_reservation, only: [:edit, :update, :destroy]

  def index
    @reservations = current_user.reservations
  end

  def confirm
    unless room = Room.find_by(id: reservation_params[:room_id])
      flash[:alert] = "ご指定になった施設は存在しません。"
      redirect_back(fallback_location: root_path) and return
    end

    @reservation = current_user.reservations.find_or_initialize_by(id: reservation_params[:id])
    @reservation.assign_attributes(reservation_params)

    return if @reservation.valid?

    flash.now[:alert] = "予約情報が不足しています。"

    if @reservation.new_record?
      @room = room
      render "rooms/show"
    else
      render :edit
    end
  end

  def edit; end

  def create
    @reservation = current_user.reservations.build(reservation_params)

    if @reservation.save
      redirect_to reservations_url, notice: "施設の予約が完了しました。"
    else
      flash.now[:alert] = "施設の予約に失敗しました。"
      render :new
    end
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to reservations_url, notice: "施設の予約情報を更新しました。"
    else
      flash.now[:alert] = "施設の予約情報の更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    if @reservation.destroy
      flash[:notice] = "施設の予約情報を削除しました。"
    else
      flash[:alert] = "施設の予約情報の削除に失敗しました。"
    end

    redirect_to reservations_url
  end

  private

  def set_own_reservation
    @reservation = current_user.reservations.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:id, :room_id, :start_date, :end_date, :person_num)
  end
end
