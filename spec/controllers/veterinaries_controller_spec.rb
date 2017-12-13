require 'rails_helper'

RSpec.describe VeterinariesController, type: :controller do
  render_views

  let(:json) { JSON.parse(response.body) }

  let(:valid_attributes) do
    {
      name: 'Diagnovet',
      phone: '261 111 2233',
      email: 'diagnovet@email.com'
    }
  end

  let(:invalid_attributes) do
    {
      email: 'invalid'
    }
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      Veterinary.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #index.json' do
    let(:veterinary1) { Veterinary.first }
    let(:veterinary2) { Veterinary.second }

    before(:each) do
      Veterinary.create! valid_attributes
      Veterinary.create!(
        name: 'Vetdiagno',
        phone: '261 111 1111',
        email: 'vetdiagno@email.com'
      )
      veterinary1.veterinarians = [
        Veterinarian.create!(full_name: 'Eduardo'),
        Veterinarian.create!(full_name: 'Bibi')
      ]
      veterinary2.veterinarians = [
        Veterinarian.create!(full_name: 'Melisa'),
        Veterinarian.create!(full_name: 'Natalia'),
        Veterinarian.create!(full_name: 'Damián')
      ]
      get :index, format: :json
    end

    context 'all veterinaries' do
      it 'should return all veterinaries' do
        expect(json.map { |a| a['name'] }).to contain_exactly(
          a_string_matching(veterinary1.name),
          a_string_matching(veterinary2.name)
        )
        expect(json.map { |a| a['phone'] }).to contain_exactly(
          a_string_matching(veterinary1.phone),
          a_string_matching(veterinary2.phone)
        )
        expect(json.map { |a| a['email'] }).to contain_exactly(
          a_string_matching(veterinary1.email),
          a_string_matching(veterinary2.email)
        )
        veterinary1_json = json[0]
        expect(veterinary1_json['veterinarians'].count).to be(2)
        expect(veterinary1_json['veterinarians'][0]['full_name']).to eq('Eduardo')
        expect(veterinary1_json['veterinarians'][1]['full_name']).to eq('Bibi')
        veterinary2_json = json[1]
        expect(veterinary2_json['veterinarians'].count).to be(3)
        expect(veterinary2_json['veterinarians'][0]['full_name']).to eq('Melisa')
        expect(veterinary2_json['veterinarians'][1]['full_name']).to eq('Natalia')
        expect(veterinary2_json['veterinarians'][2]['full_name']).to eq('Damián')
      end
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      veterinary = Veterinary.create! valid_attributes
      get :show, params: {id: veterinary.to_param}, session: valid_session
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
      veterinary = Veterinary.create! valid_attributes
      get :edit, params: {id: veterinary.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Veterinary' do
        expect {
          post :create, params: {veterinary: valid_attributes}, session: valid_session
        }.to change(Veterinary, :count).by(1)
      end

      it 'redirects to the created veterinary' do
        post :create, params: {veterinary: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Veterinary.last)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the \'new\' template)' do
        post :create, params: {veterinary: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          name: 'La Vete'
        }
      end

      it 'updates the requested veterinary' do
        veterinary = Veterinary.create! valid_attributes
        put :update,
          params: {id: veterinary.to_param, veterinary: new_attributes},
          session: valid_session
        veterinary.reload
        expect(veterinary.name).to eq('La Vete')
      end

      it 'redirects to the veterinary' do
        veterinary = Veterinary.create! valid_attributes
        put :update,
          params: {id: veterinary.to_param, veterinary: valid_attributes},
          session: valid_session
        expect(response).to redirect_to(veterinary)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the \'edit\' template)' do
        veterinary = Veterinary.create! valid_attributes
        put :update,
          params: {id: veterinary.to_param, veterinary: invalid_attributes},
          session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested veterinary' do
      veterinary = Veterinary.create! valid_attributes
      expect {
        delete :destroy, params: {id: veterinary.to_param}, session: valid_session
      }.to change(Veterinary, :count).by(-1)
    end

    it 'redirects to the veterinaries list' do
      veterinary = Veterinary.create! valid_attributes
      delete :destroy, params: {id: veterinary.to_param}, session: valid_session
      expect(response).to redirect_to(veterinaries_url)
    end
  end

end
