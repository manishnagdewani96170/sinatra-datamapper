# require_relative '../serializers/user_serializer'
class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String, required: true, :unique_index => true, format: :email_address
  property :password, String, required: true, length: 8..50
  property :token, String, required: true, length: 8..50
  property :created_at, DateTime
  property :updated_at, DateTime

  validates_uniqueness_of :email

end

