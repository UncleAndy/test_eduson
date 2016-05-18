class ImagesController < ApplicationController
  before_filter :authenticate_user!, except: [:index]
  before_filter :check_user_permission, except: [:index]

  before_filter :set_user_id
  before_filter :set_image_id, :only => [:edit, :update, :destroy]

  def index
    @user = User.find_by_id(@user_id)
    if (@user.blank?)
      redirect_to root_path, notice: I18n.t('errors.absent_collection')
    else
      @images = @user.images

      @self_collection = (current_user.present? && (current_user.id.to_i == @user_id))
    end
  end

  def new
    @image = current_user.images.new
    @user = current_user
  end

  def create
    @image = Image.new(new_image_params)
    @image.user_id = @user_id

    if @image.save
      redirect_to user_images_path(@user_id)
    else
      redirect_to new_user_image_path(@user_id), notice: I18n.t('errors.images.create_error')
    end
  end

  def edit
    @image = Image.find(@image_id)
    @user = current_user
  end

  def update
    @image = Image.find(@image_id)
    if @image.update_column(:title, params[:image][:title])
      redirect_to user_images_path(@user_id)
    else
      redirect_to new_user_image_path(@user_id), notice: I18n.t('errors.images.update_error')
    end
  end

  def destroy
    @image = Image.find(@image_id)
    @image.remove_location!
    @image.delete
    redirect_to user_images_path(@user_id)
  end

  private

  def set_user_id
    @user_id = params[:user_id].to_i
  end

  def set_image_id
    @image_id = params[:id].to_i
  end

  def new_image_params
    params.require(:image).permit(:user_id, :title, :location)
  end
end
