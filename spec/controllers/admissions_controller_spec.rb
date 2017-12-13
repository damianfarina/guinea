require 'rails_helper'

RSpec.describe AdmissionsController, type: :controller do
  render_views

  let(:json) { JSON.parse(response.body) }

  let(:petitioner) do
    Veterinarian.create!(
      full_name: 'Montoto (Veterinary El Cachorro)',
      phone: '261 666 5555',
      email: 'montoto@elcachorro.com'
    )
  end

  let(:valid_attributes) do
    {
      petitioner_name: petitioner.name,
      petitioner_id: petitioner.id,
      petitioner_type: petitioner.class.to_s,
      petitioner_phone: '261 666 5555',
      petitioner_email: 'montoto@elcachorro.com',
      patient_name: 'Wanda',
      species: 'canine',
      sex: 'female',
      breed: 'Rottweiler',
      months: '37',
      owner_name: 'Karina Yonson',
      comments: 'Hello, do not forget this'
    }
  end

  let(:invalid_attributes) {
    valid_attributes.merge(
      petitioner_name: '',
      petitioner_id: '',
      petitioner_type: ''
    )
  }

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      admission = Admission.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #index.json' do
    let(:admission) { Admission.first }
    before do
      Admission.create! valid_attributes
      get :index, format: :json
    end

    context 'all admissions' do
      it 'should return all admissions' do
        expect(json.map { |a| a['patient_name']}).to include(admission.patient_name)
      end
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      admission = Admission.create! valid_attributes
      get :show, params: {id: admission.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      admission = Admission.create! valid_attributes
      get :edit, params: {id: admission.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:new_admission_attributes) do
        attrs = valid_attributes.delete_if { |k, v|
          [:petitioner_id, :petitioner_type].include?(k)
        }
        attrs[:petitioner_name] = 'Damián Farina'
        attrs[:petitioner_email] = 'd@f.com'
        attrs[:petitioner_phone] = '111 222 3333'
        attrs
      end

      it 'creates a new Admission' do
        expect {
          post :create, params: {admission: new_admission_attributes}, session: valid_session
        }.to change(Admission, :count).by(1)
        new_petitioner = Veterinarian.where(full_name: new_admission_attributes[:petitioner_name]).first
        expect(new_petitioner).to be_present
        admission = Admission.first
        expect(admission.petitioner_name).to eq(new_petitioner.full_name)
        expect(admission.petitioner_id).to eq(new_petitioner.id)
        expect(admission.petitioner_type).to eq(new_petitioner.class.to_s)
        expect(admission.petitioner_phone).to eq(new_petitioner.phone)
        expect(admission.petitioner_email).to eq(new_petitioner.email)
        expect(admission.patient_name).to eq(new_admission_attributes[:patient_name])
        expect(admission.species).to eq(new_admission_attributes[:species])
        expect(admission.sex).to eq(new_admission_attributes[:sex])
        expect(admission.breed).to eq(new_admission_attributes[:breed])
        expect(admission.months.to_s).to eq(new_admission_attributes[:months])
        expect(admission.owner_name).to eq(new_admission_attributes[:owner_name])
        expect(admission.comments).to eq(new_admission_attributes[:comments])
      end

      it 'redirects to the created admission' do
        post :create, params: {admission: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Admission.last)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the \'new\' template)' do
        post :create, params: {admission: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          months: 15
        }
      end

      it 'updates the requested admission' do
        admission = Admission.create! valid_attributes
        put :update, params: {id: admission.to_param, admission: new_attributes}, session: valid_session
        admission.reload
        expect(admission.months).to eq(15)
      end

      it 'redirects to the admission' do
        admission = Admission.create! valid_attributes
        put :update, params: {id: admission.to_param, admission: valid_attributes}, session: valid_session
        expect(response).to redirect_to(admission)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the \'edit\' template)' do
        admission = Admission.create! valid_attributes
        put :update, params: {id: admission.to_param, admission: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested admission' do
      admission = Admission.create! valid_attributes
      expect {
        delete :destroy, params: {id: admission.to_param}, session: valid_session
      }.to change(Admission, :count).by(-1)
    end

    it 'redirects to the admissions list' do
      admission = Admission.create! valid_attributes
      delete :destroy, params: {id: admission.to_param}, session: valid_session
      expect(response).to redirect_to(admissions_url)
    end
  end

end
