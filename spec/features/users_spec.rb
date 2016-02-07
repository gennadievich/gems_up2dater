require "spec_helper"

feature "Users" do
  scenario "Create new user with valid data" do
    visit new_user_path

    fill_in "user_name",                  with: Faker::Name.name
    fill_in "user_email",                 with: Faker::Internet.email
    fill_in "user_password",              with: "pass"
    fill_in "user_password_confirmation", with: "pass"

    click_button "Create user"

    expect(User.count).to be(1)
    expect(page).to have_content("User created!")
  end

  scenario "Create new user with invalid data" do
    visit new_user_path

    fill_in "user_name",                  with: nil
    fill_in "user_email",                 with: nil
    fill_in "user_password",              with: "pass"
    fill_in "user_password_confirmation", with: "pass1"

    click_button "Create user"

    expect(User.count).to be(0)
    expect(page).to have_content("Password confirmation doesn't match PasswordName can't be blankEmail can't be blank")
  end
end