class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  # 画像の最大サイズを指定する
  process resize_to_limit: [450, 450]

  # 本番環境ではfog、それ以外の環境ではローカルに画像を保存する
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  # アップロードファイルの保存先ディレクトリは上書き可能
  # 下記はデフォルトの保存先  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # 画像がなかったときのデフォルト画像の指定
  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url(*args) # コメントアウトを外す
   #   # For Rails 3.1+ asset pipeline compatibility:
   #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
     "default.jpg" # 書き加える
   #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end 

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # アップロード可能な拡張子のリスト
  def extension_whitelist
    %w(jpg jpeg gif png jfif)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
