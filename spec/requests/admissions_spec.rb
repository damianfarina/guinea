require 'rails_helper'

RSpec.describe 'Admissions', type: :request do
  let!(:admission) { create :admission }

  describe 'GET /admissions' do
    it 'should return a list of admissions' do
      get admissions_path
      expect(response).to have_http_status(200)
    end
  end
end
