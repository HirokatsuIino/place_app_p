if Rails.env.production? || Rails.env.staging? || Rails.env.development?
  require "refile/s3"

  aws = {
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region: "ap-northeast-1",
    bucket: ENV['S3_BUCKET'],
  }
  Refile.cache = Refile::S3.new(prefix: "cache", **aws)
  Refile.store = Refile::S3.new(prefix: "store", **aws)

  if Rails.env.production?
    Refile.cdn_host = '//d2y5cxtzntmkis.cloudfront.net'
  elsif Rails.env.staging?
    Refile.cdn_host = '//d3oc4zzeqj4quz.cloudfront.net'
  end
end

Refile::MiniMagick.prepend Module.new {
  [:limit, :fit, :fill, :pad].each do |action|
    define_method(action) do |img, *args|
      super(img, *args)
      img.auto_orient
    end
  end
}
