require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/contact.db")

class Contact
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :address, String
  property :department, String
  property :message, String
end

DataMapper.finalize

#DataMapper.auto_migrate!

Contact.auto_upgrade!