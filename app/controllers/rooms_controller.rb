class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:posts, :create, :new, :edit, :update, :destroy]
  before_action :set_own_room, only: [:edit, :update, :destroy]

  def index
    @rooms = Room.with_attached_image
                 .search_by_area(search_params[:area])
                 .search_by_keyword(search_params[:keyword])
  end

  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def new
    @room = Room.new
  end

  def edit; end

  def create
    @room = current_user.rooms.build(room_params)

    if @room.save
      redirect_to @room, notice: "施設が作成されました。"
    else
      flash.now[:alert] = "施設の作成に失敗しました。"
      render :new
    end
  end

  def update
    if @room.update(room_params)
      redirect_to @room, notice: "施設情報が更新されました。"
    else
      flash.now[:alert] = "施設情報の更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    if @room.destroy
      flash[:notice] = "施設が削除されました。"
    else
      flash[:alert] = "施設の削除に失敗しました。"
    end

    redirect_to rooms_url
  end

  def own
    @rooms = current_user.rooms.with_attached_image
  end

  private

  def set_own_room
    @room = current_user.rooms.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :content, :address, :price, :image)
  end

  def search_params
    params.permit(:area, :keyword)
  end
end
