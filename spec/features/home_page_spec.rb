require "spec_helper"

feature "Home page" do
  scenario "visit home page" do
    visit home_page_path

    expect(page).to have_css("header", text: "Gems up2dater")
    #expect(page).to
  end
end