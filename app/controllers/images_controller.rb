class ImagesController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

  before_filter :set_collection_id

  def index
    @user = User.find(@collection_id)
    @images = @user.images

    @self_collection = (current_user.present? && (current_user.id.to_i == @collection_id))
  end

  def new
    @image = current_user.images.new
  end

  def create
    @image = Image.new(image_params)

    if @image.save
      redirect_to collection_images_path(@collection_id)
    else
      redirect_to new_collection_image_path(@collection_id), notice: I18n.t('errors.images.create_error')
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_collection_id
    @collection_id = params[:collection_id].to_i
  end

  def image_params
    params.require(:image).permit(:user_id, :title, :location)
  end
end
