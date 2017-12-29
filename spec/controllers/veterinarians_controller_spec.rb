require 'rails_helper'

RSpec.describe VeterinariansController, type: :controller do
  render_views

  let(:json) { JSON.parse(response.body) }
  let(:valid_attributes) { attributes_for(:veterinarian) }
  let(:invalid_attributes) { {email: 'invalid'} }
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      create :veterinarian
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #index.json' do
    let(:veterinarian1) { Veterinarian.first }
    let(:veterinarian2) { Veterinarian.second }

    before(:each) do
      create :veterinarian
      create :veterinarian
      veterinarian1.veterinaries = [
        create(:veterinary, name: 'Bichitos'),
        create(:veterinary, name: 'Mascotitas')
      ]
      veterinarian2.veterinaries = [
        create(:veterinary, name: 'Animalitos')
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
        expect(veterinarian1_json['veterinaries'].map { |v| v['name'] }).to contain_exactly(
          'Bichitos',
          'Mascotitas'
        )
        veterinarian2_json = json[1]
        expect(veterinarian2_json['veterinaries'].count).to be(1)
        expect(veterinarian2_json['veterinaries'].map { |v| v['name'] }).to contain_exactly(
          'Animalitos'
        )
      end
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      veterinarian = create :veterinarian
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
      veterinarian = create :veterinarian
      get :edit, params: {id: veterinarian.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Veterinarian' do
        expect do
          post :create, params: {veterinarian: valid_attributes}, session: valid_session
        end.to change(Veterinarian, :count).by(1)
      end

      it 'redirects to the created veterinarian' do
        post :create, params: {veterinarian: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Veterinarian.last)
      end

      it 'should save veterinaries' do
        veterinaries_attributes = {
          veterinary_ids: [
            create(:veterinary).id,
            create(:veterinary).id
          ]
        }
        post :create,
          params: {veterinarian: valid_attributes, veterinaries: veterinaries_attributes},
          session: valid_session
        veterinarian = Veterinarian.last
        expect(veterinarian.veterinaries.count).to be(2)
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
      let(:veterinary1) { create :veterinary }
      let(:veterinary2) { create :veterinary }
      let(:veterinarian) { create :veterinarian, veterinaries: [veterinary1, veterinary2] }
      let(:new_attributes) do
        {
          full_name: 'Hernesto'
        }
      end
      let(:new_veterinaries_attributes) do
        {
          veterinary_ids: [veterinary1.id]
        }
      end

      it 'updates the requested veterinarian' do
        put :update,
          params: {id: veterinarian.to_param, veterinarian: new_attributes},
          session: valid_session
        veterinarian.reload
        expect(veterinarian.full_name).to eq('Hernesto')
      end

      it 'redirects to the veterinarian' do
        put :update,
          params: {id: veterinarian.to_param, veterinarian: valid_attributes},
          session: valid_session
        expect(response).to redirect_to(veterinarian)
      end

      it 'should update veterinaries' do
        put :update,
          params: {
            id: veterinarian.to_param,
            veterinarian: valid_attributes,
            veterinaries: new_veterinaries_attributes
          },
          session: valid_session
        veterinarian.reload
        expect(veterinarian.veterinaries.count).to eq(1)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the \'edit\' template)' do
        veterinarian = create :veterinarian
        put :update,
          params: {id: veterinarian.to_param, veterinarian: invalid_attributes},
          session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested veterinarian' do
      veterinarian = create :veterinarian
      expect do
        delete :destroy, params: {id: veterinarian.to_param}, session: valid_session
      end.to change(Veterinarian, :count).by(-1)
    end

    it 'redirects to the veterinarians list' do
      veterinarian = create :veterinarian
      delete :destroy, params: {id: veterinarian.to_param}, session: valid_session
      expect(response).to redirect_to(veterinarians_url)
    end
  end

end
