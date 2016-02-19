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

  scenario "Admin successfully visits users page" do
    admin = FactoryGirl.create(:admin)
    sign_in(admin)

    expect(page).to have_content("Welcome back, #{admin.name}")

    visit users_path

    expect(page).to have_css("table", text: "#{admin.email}")
  end

  scenario "User unsuccessfully visits users and create user page" do
    sign_in(user)

    expect(page).to have_content("Welcome back, #{user.name}")

    visit users_path

    expect(page).to have_content("You don't have access to this page")

    visit new_user_path

    expect(page).to have_content("You don't have access to this page")
  end
end