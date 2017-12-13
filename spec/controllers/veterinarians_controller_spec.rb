require 'rails_helper'

RSpec.describe VeterinariansController, type: :controller do
  render_views

  let(:json) { JSON.parse(response.body) }

  let(:valid_attributes) do
    {
      full_name: 'Damián Farina',
      phone: '261 412 5966',
      email: 'damianfarina@email.com'
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
      Veterinarian.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #index.json' do
    let(:veterinarian1) { Veterinarian.first }
    let(:veterinarian2) { Veterinarian.second }

    before(:each) do
      Veterinarian.create! valid_attributes
      Veterinarian.create!(
        name: 'Pity',
        phone: '261 111 1111',
        email: 'pity@vetdiagno.com'
      )
      veterinarian1.veterinaries = [
        Veterinary.create!(name: 'Bichitos'),
        Veterinary.create!(name: 'Mascotitas')
      ]
      veterinarian2.veterinaries = [
        Veterinary.create!(name: 'Animalitos')
      ]
      get :index, format: :json
    end

    context 'all veterinarians' do
      it 'should return all veterinarians' do
        expect(json.map { |a| a['full_name'] }).to contain_exactly(
          a_string_matching(veterinarian1.full_name),
          a_string_matching(veterinarian2.full_name)
        )
        expect(json.map { |a| a['phone'] }).to contain_exactly(
          a_string_matching(veterinarian1.phone),
          a_string_matching(veterinarian2.phone)
        )
        expect(json.map { |a| a['email'] }).to contain_exactly(
          a_string_matching(veterinarian1.email),
          a_string_matching(veterinarian2.email)
        )
        veterinarian1_json = json[0]
        expect(veterinarian1_json['veterinaries'].count).to be(2)
        expect(veterinarian1_json['veterinaries'][0]['name']).to eq('Bichitos')
        expect(veterinarian1_json['veterinaries'][1]['name']).to eq('Mascotitas')
        veterinarian2_json = json[1]
        expect(veterinarian2_json['veterinaries'].count).to be(1)
        expect(veterinarian2_json['veterinaries'][0]['name']).to eq('Animalitos')
      end
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      veterinarian = Veterinarian.create! valid_attributes
      get :show, params: {id: veterinarian.to_param}, session: valid_session
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
      veterinarian = Veterinarian.create! valid_attributes
      get :edit, params: {id: veterinarian.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Veterinarian' do
        expect {
          post :create, params: {veterinarian: valid_attributes}, session: valid_session
        }.to change(Veterinarian, :count).by(1)
      end

      it 'redirects to the created veterinarian' do
        post :create, params: {veterinarian: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Veterinarian.last)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the \'new\' template)' do
        post :create, params: {veterinarian: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          full_name: 'Hernesto'
        }
      end

      it 'updates the requested veterinarian' do
        veterinarian = Veterinarian.create! valid_attributes
        put :update,
          params: {id: veterinarian.to_param, veterinarian: new_attributes},
          session: valid_session
        veterinarian.reload
        expect(veterinarian.full_name).to eq('Hernesto')
      end

      it 'redirects to the veterinarian' do
        veterinarian = Veterinarian.create! valid_attributes
        put :update,
          params: {id: veterinarian.to_param, veterinarian: valid_attributes},
          session: valid_session
        expect(response).to redirect_to(veterinarian)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the \'edit\' template)' do
        veterinarian = Veterinarian.create! valid_attributes
        put :update,
          params: {id: veterinarian.to_param, veterinarian: invalid_attributes},
          session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested veterinarian' do
      veterinarian = Veterinarian.create! valid_attributes
      expect {
        delete :destroy, params: {id: veterinarian.to_param}, session: valid_session
      }.to change(Veterinarian, :count).by(-1)
    end

    it 'redirects to the veterinarians list' do
      veterinarian = Veterinarian.create! valid_attributes
      delete :destroy, params: {id: veterinarian.to_param}, session: valid_session
      expect(response).to redirect_to(veterinarians_url)
    end
  end

end
