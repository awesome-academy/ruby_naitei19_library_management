require "rails_helper"
include SessionsHelper

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  before { log_in user }

  describe "GET #show" do
    it "renders the show template" do
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new user" do
        expect {
          post :create, params: { user: attributes_for(:user) }
        }.to change(User, :count).by(1)
      end

      it "sends an activation email" do
        expect_any_instance_of(User).to receive(:send_activation_email)
        post :create, params: { user: attributes_for(:user) }
      end

      it "redirects to root_url" do
        post :create, params: { user: attributes_for(:user) }
        expect(response).to redirect_to(root_url)
      end
    end

    context "with invalid params" do
      it "renders the new template with unprocessable entity status" do
        post :create, params: { user: attributes_for(:user, email: nil) }
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET #edit" do
    it "renders the edit template" do
      get :edit, params: { id: user.id }
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      it "updates the user" do
        new_name = "New Name"
        patch :update, params: { id: user.id, user: { name: new_name } }
        user.reload
        expect(user.name).to eq(new_name)
      end

      it "redirects to the updated user" do
        patch :update, params: { id: user.id, user: attributes_for(:user) }
        expect(response).to redirect_to(user)
      end
    end

    context "with invalid params" do
      it "renders the edit template with unprocessable entity status" do
        patch :update, params: { id: user.id, user: { email: "invalid_email" } }
        expect(response).to render_template(:edit)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
