require "spec_helper"

feature "Projects" do
  let(:user) { create(:user) }

  scenario "User creates new project with valid data", js: true do
    sign_in(user)
    project_name = Faker::Company.name

    visit user_projects_path(user)
    click_link("show-project-form-button")

    fill_in "project_name",         with: project_name
    fill_in "project_description",  with: Faker::Lorem.sentence
    fill_in "project_link",         with: Faker::Internet.url

    click_button "Create project"

    expect(page).to have_text("Project '#{project_name}' successfully created!")
  end

  scenario "User creates new project with invalid data", js: true do
    sign_in(user)

    visit user_projects_path(user)
    click_link("show-project-form-button")

    fill_in "project_name",         with: nil
    fill_in "project_description",  with: nil
    fill_in "project_link",         with: nil

    click_button "Create project"

    expect(Project.count).to be(0)
    expect(page).to have_text("Name can't be blank")
  end

  scenario "User visits project's page" do
    sign_in(user)
    project = create(:project, user_id: user.id)

    visit user_project_path(user, project)

    expect(page).to have_text(project.name)
    expect(page).to have_css("table")
  end

  scenario "User deletes his project" do
    sign_in(user)
    project = create(:project, user_id: user.id)

    visit user_projects_path(user)

    first('.glyphicon-trash').click #click delete button

    expect(Project.count).to be(0)
    expect(page).to have_text("Project '#{project.name}' was deleted.")
    expect(page).to have_text("Add your first project! Push green cross!")
  end
end