require "spec_helper"

feature "Home page" do
  scenario "visit home page" do
    visit home_page_path

    expect(page).to have_css("h1", text: "Home page")
  end
end