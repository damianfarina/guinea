require 'rails_helper'

RSpec.describe AdmissionsController, type: :controller do
  render_views

  let(:json) { JSON.parse(response.body) }
  let(:petitioner_attributes) { attributes_for :veterinarian }
  let(:valid_attributes) do
    attributes_for :admission,
      petitioner: nil,
      petitioner_name: petitioner_attributes[:full_name],
      petitioner_email: petitioner_attributes[:email]
  end
  let(:invalid_attributes) do
    valid_attributes.merge(
      petitioner_name: '',
      veterinarian_id: ''
    )
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      create :admission
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #index.json' do
    let(:admission) { Admission.first }
    before(:each) do
      create :admission
      get :index, format: :json
    end

    context 'all admissions' do
      it 'should return all admissions' do
        expect(json.map { |a| a['patient_name'] }).to include(admission.patient_name)
      end
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      admission = create :admission
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
      admission = create :admission
      get :edit, params: {id: admission.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:new_admission_attributes) do
        attrs = valid_attributes.delete_if { |k, _v|
          %i[veterinarian_id].include?(k)
        }
        attrs[:petitioner_name] = 'Damián Farina'
        attrs[:petitioner_email] = 'd@f.com'
        attrs[:petitioner_phone] = '111 222 3333'
        attrs
      end

      it 'creates a new Admission' do
        expect do
          post :create, params: {admission: new_admission_attributes}, session: valid_session
        end.to change(Admission, :count).by(1)
        new_petitioner = Veterinarian.where(full_name: new_admission_attributes[:petitioner_name]).first
        expect(new_petitioner).to be_present
        admission = Admission.first
        expect(admission.petitioner_name).to eq(new_petitioner.full_name)
        expect(admission.veterinarian_id).to eq(new_petitioner.id)
        expect(admission.petitioner_phone).to eq(new_petitioner.phone)
        expect(admission.petitioner_email).to eq(new_petitioner.email)
        expect(admission.patient_name).to eq(new_admission_attributes[:patient_name])
        expect(admission.species).to eq(new_admission_attributes[:species].to_s)
        expect(admission.sex).to eq(new_admission_attributes[:sex])
        expect(admission.breed).to eq(new_admission_attributes[:breed])
        expect(admission.age).to eq(new_admission_attributes[:age])
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
          age: '3a11m'
        }
      end

      it 'updates the requested admission' do
        admission = create :admission
        put :update, params: {id: admission.to_param, admission: new_attributes}, session: valid_session
        admission.reload
        expect(admission.age).to eq('3a11m')
      end

      it 'redirects to the admission' do
        admission = create :admission
        put :update, params: {id: admission.to_param, admission: valid_attributes}, session: valid_session
        expect(response).to redirect_to(admission)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the \'edit\' template)' do
        admission = create :admission
        put :update, params: {id: admission.to_param, admission: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested admission' do
      admission = create :admission
      expect {
        delete :destroy, params: {id: admission.to_param}, session: valid_session
      }.to change(Admission, :count).by(-1)
    end

    it 'redirects to the admissions list' do
      admission = create :admission
      delete :destroy, params: {id: admission.to_param}, session: valid_session
      expect(response).to redirect_to(admissions_url)
    end
  end

end
