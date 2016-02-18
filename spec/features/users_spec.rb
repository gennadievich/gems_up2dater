require "spec_helper"

feature "Users" do
  scenario "Create new user with valid data" do
    visit new_user_path
    user_name = Faker::Name.name

    fill_in "user_name",                  with: user_name
    fill_in "user_email",                 with: Faker::Internet.email
    fill_in "user_password",              with: "pass"
    fill_in "user_password_confirmation", with: "pass"

    click_button "Create user"

    expect(User.count).to be(1)
    expect(User.first.role.name) == "user"
    expect(page).to have_content("Welcome, #{user_name}")
    expect(page).to have_content("You successfully registered!")
    expect(page).to have_content("#{user_name}'s page")
  end

  scenario "Create new user with invalid data" do
    visit new_user_path

    fill_in "user_name",                  with: nil
    fill_in "user_email",                 with: nil
    fill_in "user_password",              with: "pass"
    fill_in "user_password_confirmation", with: "pass1"

    click_button "Create user"

    expect(User.count).to be(0)
    expect(page).to have_content("Password confirmation doesn't match Password")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Email can't be blank")
  end

  scenario "Admin successfully deletes user" do
    user  = FactoryGirl.create(:user)
    admin = FactoryGirl.create(:user)
    admin.update_column(:role_id, 2)

    sign_in(admin)
    visit users_path

    first('.glyphicon-trash').click #click delete button

    expect(User.count).to be(1)
    expect(page).to have_content("User '#{user.name}' was successfully deleted.")
  end

  scenario "Admin tries to delete another admin" do
    admin_del = FactoryGirl.create(:user)
    admin_del.update_column(:role_id, 2)
    admin = FactoryGirl.create(:user)
    admin.update_column(:role_id, 2)

    sign_in(admin)
    visit users_path

    first('.glyphicon-trash').click #click delete button

    expect(User.count).to be(2)
    expect(page).to have_content("You are not allowed to delete admins.")
  end
end