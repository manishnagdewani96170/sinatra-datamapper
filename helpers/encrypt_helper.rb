require 'digest/md5'

module EncryptHelper
  def encrypt(string)
    Digest::MD5.hexdigest(string)[0...22]
  end

  def generate_token
    Digest::MD5.hexdigest(rand(12345678).to_s)[0..22]
  end
end