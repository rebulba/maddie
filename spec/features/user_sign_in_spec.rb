require "rails_helper"

feature "Sign in" do
  scenario "User at wrong domain" do
    user = create(:user, domain: "wrong_domain")
    sign_in(user)

    expect(page).to have_text("Wrong domain for user!")
  end

  scenario "User at correct domain" do
    user = create(:user)
    set_host(user.domain)
    sign_in(user)

    expect(page).to have_text("Signed in successfully")
  end

  scenario "User with no domain registered yet" do
    user = create(:user, domain: nil)
    sign_in(user)

    expect(page).to have_text("Signed in successfully")
  end

  scenario "Email not registered" do
    user = build(:user)
    sign_in(user)

    expect(page).to have_text("Invalid email")
  end

  def sign_in(user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end
