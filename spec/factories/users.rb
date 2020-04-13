FactoryBot.define do
  factory :user do
    name { "testuser1" }
    email { "test1@example.com" }
    nickname { "test_nickname1" }
    password { "password" }
    password_confirmation { "password" }
    icon { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/icon.png')) }
    header { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/header.jpeg')) }
    description { "こんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちは" }
  end
end
