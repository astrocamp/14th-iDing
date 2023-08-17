CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:               'AWS',
    aws_access_key_id: Rails.application.credentials.dig(:aws, :access_key, :id),
    aws_secret_access_key: Rails.application.credentials.dig(:aws, :access_key, :secret),
    host: 's3-ap-northeast-1.amazonaws.com',
    region: 'ap-northeast-1'
  }
  config.fog_directory = Rails.application.credentials.dig(:aws, :s3_bucket_name)
end