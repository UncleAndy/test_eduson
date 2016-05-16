class Image < ActiveRecord::Base
  # :title, :location, :user_id

  mount_uploader :location, ImageUploader

  belongs_to :user

  def random_string
    @randomstring ||= SecureRandom.hex(10)
  end
end
