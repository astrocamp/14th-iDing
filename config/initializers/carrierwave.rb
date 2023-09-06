CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:               'AWS',
    aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
    aws_secret_access_key: ENV["AWS_ACCESS_KEY_SECRET"],
    host: 's3-ap-northeast-1.amazonaws.com',
    region: 'ap-northeast-1'
  }
  config.fog_directory = ENV["AWS_S3_BUCKET_NAME"]
end