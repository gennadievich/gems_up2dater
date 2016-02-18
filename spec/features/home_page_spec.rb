require "spec_helper"

feature "Home page" do
  scenario "visit home page" do
    visit home_page_path

    expect(page).to have_css("header", text: "Gems up2dater")
    expect(page).to have_text "Keep your gemlist up 2 date!"
    expect(page).to have_link("Registration")
    expect(page).to have_link("Log In")
  end
end