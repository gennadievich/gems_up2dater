require "spec_helper"

feature "User login" do
  let!(:user) {FactoryGirl.create(:user)}

  scenario "Login with valid data" do
    visit login_path

    fill_in "email", with: user.email
    fill_in "password", with: user.password

    click_button "Login"

    expect(page).to have_content("Welcome back, #{user.name}")
    expect(page).to have_content("#{user.name}'s page")
  end

  scenario "Login with invalid data" do
    visit login_path

    fill_in "email", with: user.email
    fill_in "password", with: "wrong password"

    click_button "Login"

    expect(page).to have_content("Check your email/password")
    expect(page).to have_button("Login")
  end

  scenario "Logout" do
    sign_in(user)

    click_link("Logout")

    expect(page).to have_css("header", text: "Gems up2dater")
    expect(page).to have_text "Keep your gemlist up 2 date!"
    expect(page).to have_link("Registration")
    expect(page).to have_link("Log In")
    expect(page).to have_content("See you soon!")
  end
end