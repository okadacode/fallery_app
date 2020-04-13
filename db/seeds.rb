User.create!(
  name: "user1",
  email: "user1@example.com",
  nickname: "ユーザー１",
  password: "password",
  password_confirmation: "password",
  icon: File.open("./app/assets/images/icon.png"),
  header: File.open("./app/assets/images/header.jpeg"),
  description: "こんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちはこんにちは"
)
