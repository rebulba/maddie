require "rails_helper"

feature "Creates a Project" do
  scenario "authenticated" do
    user = create(:user)
    sign_in user

    project = build(:project)
    visit new_project_path(as: user)

    fill_in "Url key", with: project.url_key
    fill_in "Title", with: project.title
    fill_in "Description", with: project.description
    click_button "Create Project"

    expect(page).to have_text(project.title)
    expect(Project.last.title).to eq(project.title)
  end

  def sign_in(user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end