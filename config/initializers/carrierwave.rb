if Rails.env.test? or Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
else
  CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => Rails.application.secrets.s3_access_key_id,
      :aws_secret_access_key  => Rails.application.secrets.s3_secret,
      :region                 => 'us-west-2'
    }
    config.asset_host     = Rails.application.secrets.cdn_media
    config.fog_directory  = Rails.application.secrets.s3_bucket
    config.fog_public     = true                                        # optional, defaults to true
    config.fog_attributes = {'Cache-Control'=>"max-age=#{365.day.to_i}"} # optional, defaults to {}
    config.storage        = :fog
  end
end