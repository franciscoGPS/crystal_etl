require "openssl"
puts OpenSSL::MD5.hash(Time.local.to_unix_f.to_s).to_s