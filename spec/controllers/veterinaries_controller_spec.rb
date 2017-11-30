require 'rails_helper'

RSpec.describe VeterinariesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Veterinary. As you add validations to Veterinary, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # VeterinariesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      veterinary = Veterinary.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      veterinary = Veterinary.create! valid_attributes
      get :show, params: {id: veterinary.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      veterinary = Veterinary.create! valid_attributes
      get :edit, params: {id: veterinary.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Veterinary" do
        expect {
          post :create, params: {veterinary: valid_attributes}, session: valid_session
        }.to change(Veterinary, :count).by(1)
      end

      it "redirects to the created veterinary" do
        post :create, params: {veterinary: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Veterinary.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {veterinary: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested veterinary" do
        veterinary = Veterinary.create! valid_attributes
        put :update, params: {id: veterinary.to_param, veterinary: new_attributes}, session: valid_session
        veterinary.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the veterinary" do
        veterinary = Veterinary.create! valid_attributes
        put :update, params: {id: veterinary.to_param, veterinary: valid_attributes}, session: valid_session
        expect(response).to redirect_to(veterinary)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        veterinary = Veterinary.create! valid_attributes
        put :update, params: {id: veterinary.to_param, veterinary: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested veterinary" do
      veterinary = Veterinary.create! valid_attributes
      expect {
        delete :destroy, params: {id: veterinary.to_param}, session: valid_session
      }.to change(Veterinary, :count).by(-1)
    end

    it "redirects to the veterinaries list" do
      veterinary = Veterinary.create! valid_attributes
      delete :destroy, params: {id: veterinary.to_param}, session: valid_session
      expect(response).to redirect_to(veterinaries_url)
    end
  end

end
