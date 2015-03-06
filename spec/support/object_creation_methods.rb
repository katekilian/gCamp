def create_user(overrides = {})
  User.create!(
    first_name: "Kate",
    last_name: "Quail",
    email: "kate@example.com",
    password: "password",
    password_confirmation: "password"
  )
end
