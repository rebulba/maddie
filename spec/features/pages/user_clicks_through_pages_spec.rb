require "rails_helper"

feature "User navigates through pages" do
  scenario do
    user = user_at_test_domain
    first_page = create(:page, user: user, body: "first")
    second_page = create(:page, user: user, body: "second")
    third_page = create(:page, user: user, body: "third")
    fourth_hidden_page = create(:page, user: user, body: "fourth", hidden: true)

    visit root_url

    click_link(first_page.title)
    expect(page).to have_text(first_page.body)
    click_link(">")
    expect(page).to have_text(second_page.body)
    click_link(">")
    expect(page).to have_text(third_page.body)
    click_link(">")
    expect(page).to have_text(first_page.body)
    expect(page).not_to have_text(fourth_hidden_page.body)

    visit "/#{fourth_hidden_page.url_key}"
    expect(page).to have_text(fourth_hidden_page.body)
  end
end
