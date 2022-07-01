key_id = ENV["DO_KEY_ID"]
secret = ENV["DO_KEY_SECRET"]

client = Awscr::S3::Client.new("sfo3", key_id, secret, endpoint: "https://sirecom.sfo3.digitaloceanspaces.com/")
Shrine.configure do |config|
  config.storages["cache"] = Shrine::Storage::FileSystem.new("uploads", prefix: "cache")
  if LuckyEnv.production?
    config.storages["store"] = Shrine::Storage::S3.new(bucket: "attachments", client: client, public: true)
  else
    config.storages["store"] = Shrine::Storage::FileSystem.new("uploads")
  end
end
