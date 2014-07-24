CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => ENV["AWS_ACCESS_KEY_ID"], # required
    :aws_secret_access_key  => ENV["AWS_SECRET_ACCESS_KEY"], # required
    :region                 => ENV["AWS_S3_REGION"],     # optional, defaults to 'us-east-1'
    :host                   => ENV["AWS_S3_HOST"],       # optional, defaults to nil
    :endpoint               => ENV["AWS_S3_ENDPOINT"]    # optional, defaults to nil
  }
  config.fog_directory  = ENV["AWS_S3_DIRECTORY"]             # required
  # config.fog_public     = ENV["AWS_S3_PUBLIC"]                # optional, defaults to true
  # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end
