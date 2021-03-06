require "rails_helper"

RSpec.describe WelcomeController do
  describe "GET index" do
    it "returns http success" do
      test_user
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET show" do
    context "page name exists" do
      it "assigns @page to the correct user" do
        wrong_user = create(:user)
        create(:domain, host: "other.domain", user: wrong_user)
        create(:page, user: wrong_user, url_key: "2")
        page = create(:page, domain: test_user.domains.first, url_key: "1")

        get :show, url_key: page.url_key

        expect(assigns(:page)).to eq(page)
      end
    end

    context "page url_key does not exist" do
      it "raises a 404" do
        test_user
        expect do
          get :show, url_key: "not_found"
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  def test_user
    domain = create(:domain, host: "test.host")
    create(:user, domains: [domain])
  end
end
