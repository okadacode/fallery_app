FactoryBot.define do
  factory :user, class: User do
    name { "testuser1" }
    email { "test1@example.com" }
    nickname { "test_nickname1" }
    password { "password" }
    password_confirmation { "password" }
    icon { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/icon.png')) }
    header { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/header.jpeg')) }
    description { "こんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちは" }
    activated { true }
    activated_at { Time.zone.now }
  end

  factory :another, class: User do
    name { "testuser2" }
    email { "test2@example.com" }
    nickname { "test_nickname2" }
    password { "password" }
    password_confirmation { "password" }
    icon { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/icon.png')) }
    header { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/header.jpeg')) }
    description { "こんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちは" }
    activated { true }
    activated_at { Time.zone.now }
  end
end
