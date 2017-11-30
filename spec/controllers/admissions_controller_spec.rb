require 'rails_helper'

RSpec.describe AdmissionsController, type: :controller do

  let(:petitioner) do
    Veterinarian.create!(
      full_name: 'Montoto (Veterinary El Cachorro)',
      phone: '261 666 5555',
      email: 'montoto@elcachorro.com'
    )
  end

  let(:valid_attributes) do
    {
      petitioner_name: 'Montoto (Veterinary El Cachorro)',
      petitioner_id: petitioner.id,
      petitioner_type: petitioner.class.to_s,
      petitioner_phone: '261 666 5555',
      petitioner_email: 'montoto@elcachorro.com',
      patient_name: 'Wanda',
      species: 'canine',
      sex: 'female',
      breed: 'Rottweiler',
      months: '37',
      owner_name: 'Karina Yonson'
    }
  end

  let(:invalid_attributes) {
    valid_attributes.merge(
      petitioner_name: '',
      petitioner_id: '',
      petitioner_type: ''
    )
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AdmissionsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      admission = Admission.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      admission = Admission.create! valid_attributes
      get :show, params: {id: admission.to_param}, session: valid_session
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
      admission = Admission.create! valid_attributes
      get :edit, params: {id: admission.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Admission" do
        expect {
          post :create, params: {admission: valid_attributes}, session: valid_session
        }.to change(Admission, :count).by(1)
      end

      it "redirects to the created admission" do
        post :create, params: {admission: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Admission.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {admission: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        {
          months: 15
        }
      end

      it "updates the requested admission" do
        admission = Admission.create! valid_attributes
        put :update, params: {id: admission.to_param, admission: new_attributes}, session: valid_session
        admission.reload
        expect(admission.months).to eq(15)
      end

      it "redirects to the admission" do
        admission = Admission.create! valid_attributes
        put :update, params: {id: admission.to_param, admission: valid_attributes}, session: valid_session
        expect(response).to redirect_to(admission)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        admission = Admission.create! valid_attributes
        put :update, params: {id: admission.to_param, admission: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested admission" do
      admission = Admission.create! valid_attributes
      expect {
        delete :destroy, params: {id: admission.to_param}, session: valid_session
      }.to change(Admission, :count).by(-1)
    end

    it "redirects to the admissions list" do
      admission = Admission.create! valid_attributes
      delete :destroy, params: {id: admission.to_param}, session: valid_session
      expect(response).to redirect_to(admissions_url)
    end
  end

end
