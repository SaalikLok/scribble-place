require "rails_helper"

RSpec.describe ScribblesController, type: :request do
  describe "GET #index" do
    let(:user) { create(:user) }

    before do
      sign_in user
      get scribbles_path
    end

    it "responds with success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    before { get new_scribble_path }

    it "responds with success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    let(:user) { create(:user) }
    let(:scribble) { create(:scribble, user: user) }

    before do
      sign_in user
      get scribbles_path
    end

    context "with valid attributes" do
      let(:valid_attributes) { {scribble: { content: "Super duperness"}} }

      it "creates a new scribble" do
        expect {
          post scribbles_path, params: valid_attributes
        }.to change(Scribble, :count).by(1)
      end

      it "redirects to the scribbles index" do
        post scribbles_path, params: valid_attributes
        expect(response).to redirect_to(scribbles_path)
      end
    end

    context "with invalid attributes" do
      let(:invalid_attributes) { {scribble: {content: ""}} }

      it "does not create a new scribble" do
        expect {
          post scribbles_path, params: invalid_attributes
        }.not_to change(Scribble, :count)
      end

      it "returns an unprocessable entity status" do
        post scribbles_path, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET #edit" do
    let(:user) { create(:user) }
    let(:other_user) { create(:user, email: "otheruser@scribble.place") }
    let(:scribble) { create(:scribble, user: user) }

    before do
      sign_in user
    end

    context "when user is the owner" do
      it "renders the edit template" do
        get edit_scribble_path(scribble)
        expect(response).to have_http_status(:success)
      end
    end

    context "when user is not the owner" do
      before { sign_in other_user }

      it "redirects to the scribbles path" do
        get edit_scribble_path(scribble)
        expect(response).to redirect_to(scribbles_path)
      end
    end
  end

  describe "PATCH #update" do
    let(:user) { create(:user) }
    let(:scribble) { create(:scribble, user: user, content: "Scribble content") }

    before do
      sign_in user
    end

    context "with valid attributes" do
      it "updates the scribble" do
        patch scribble_path(scribble), params: {scribble: {content: "Updated scribble content"}}
        scribble.reload
        expect(scribble.content).to eq "Updated scribble content"
      end
    end

    context "with invalid attributes" do
      it "re-renders the edit template" do
        patch scribble_path(scribble), params: {scribble: {isengard: "Saruman ruins it for everyone"}}
        expect(scribble.content).to eq "Scribble content"
      end
    end
  end

  describe "DELETE #destroy" do
    let(:user) { create(:user) }
    let(:other_user) { create(:user, email: "otheremail@scribble.place") }
    let(:scribble) { create(:scribble, user: user) }

    context "when user is the owner of the scribble" do
      before { sign_in user }

      it "deletes the scribble" do
        expect {
          delete scribble_path(scribble)
        }.to change(Scribble, :count).by(-1)
      end
    end

    context "when user is not the owner of the scribble" do
      before { sign_in other_user }

      it "does not delete the scribble" do
        expect {
          delete scribble_path(scribble)
        }.not_to change(Scribble, :count)
      end
    end
  end
end
