require 'rails_helper'

RSpec.describe VeterinariesController, type: :controller do
  render_views

  let(:json) { JSON.parse(response.body) }
  let(:valid_attributes) { attributes_for(:veterinary) }
  let(:invalid_attributes) { {email: 'invalid'} }
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      create :veterinary
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #index.json' do
    let(:veterinary1) { Veterinary.first }
    let(:veterinary2) { Veterinary.second }

    before(:each) do
      create :veterinary_with_veterinarians, veterinarians_count: 2
      create :veterinary_with_veterinarians, veterinarians_count: 3
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
        expect(veterinary1_json['veterinarians'].map { |a| a['full_name'] }).to contain_exactly(
          a_string_matching(Veterinarian.first.full_name),
          a_string_matching(Veterinarian.second.full_name)
        )

        veterinary2_json = json[1]
        expect(veterinary2_json['veterinarians'].count).to be(3)
        expect(veterinary2_json['veterinarians'].map { |a| a['full_name'] }).to contain_exactly(
          a_string_matching(Veterinarian.third.full_name),
          a_string_matching(Veterinarian.fourth.full_name),
          a_string_matching(Veterinarian.fifth.full_name)
        )
      end
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      veterinary = create :veterinary
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
      veterinary = create :veterinary
      get :edit, params: {id: veterinary.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Veterinary' do
        expect do
          post :create, params: {veterinary: valid_attributes}, session: valid_session
        end.to change(Veterinary, :count).by(1)
      end

      it 'redirects to the created veterinary' do
        post :create, params: {veterinary: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Veterinary.last)
      end

      it 'should save veterinarians' do
        veterinarians_attributes = {
          veterinarian_ids: [
            create(:veterinarian).id,
            create(:veterinarian).id
          ]
        }
        post :create,
          params: {veterinary: valid_attributes, veterinarians: veterinarians_attributes},
          session: valid_session
        veterinary = Veterinary.last
        expect(veterinary.veterinarians.count).to be(2)
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
      let(:veterinary) { create :veterinary_with_veterinarians, veterinarians_count: 2 }
      let(:new_veterinarian) { create :veterinarian }
      let(:veterinarians_attributes) do
        {
          veterinarian_ids: [
            *veterinary.veterinarians.map(&:id),
            new_veterinarian.id
          ]
        }
      end

      it 'updates the requested veterinary' do
        put :update,
          params: {
            id: veterinary.to_param,
            veterinary: {name: 'La Vete'},
            veterinarians: veterinarians_attributes
          },
          session: valid_session
        veterinary.reload
        expect(veterinary.name).to eq('La Vete')
        expect(veterinary.veterinarians.map(&:full_name)).to contain_exactly(
          a_string_matching(Veterinarian.first.full_name),
          a_string_matching(Veterinarian.second.full_name),
          a_string_matching(Veterinarian.third.full_name)
        )
      end

      it 'should not save veterinarians if there is an error on veterinary' do
        put :update,
          params: {
            id: veterinary.to_param,
            veterinary: {name: ''},
            veterinarians: veterinarians_attributes
          },
          session: valid_session
        veterinary.reload
        expect(veterinary.name).not_to eq('')
        expect(veterinary.veterinarians.map(&:full_name)).to contain_exactly(
          a_string_matching(Veterinarian.first.full_name),
          a_string_matching(Veterinarian.second.full_name)
        )
      end

      it 'redirects to the veterinary' do
        put :update,
          params: {id: veterinary.to_param, veterinary: valid_attributes},
          session: valid_session
        expect(response).to redirect_to(veterinary)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the \'edit\' template)' do
        veterinary = create :veterinary
        put :update,
          params: {id: veterinary.to_param, veterinary: invalid_attributes},
          session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested veterinary' do
      veterinary = create :veterinary
      expect do
        delete :destroy, params: {id: veterinary.to_param}, session: valid_session
      end.to change(Veterinary, :count).by(-1)
    end

    it 'redirects to the veterinaries list' do
      veterinary = create :veterinary
      delete :destroy, params: {id: veterinary.to_param}, session: valid_session
      expect(response).to redirect_to(veterinaries_url)
    end
  end

end
