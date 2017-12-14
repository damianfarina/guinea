require 'rails_helper'

RSpec.describe VeterinariansController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: '/veterinarians').to route_to('veterinarians#index')
    end

    it 'routes to #new' do
      expect(get: '/veterinarians/new').to route_to('veterinarians#new')
    end

    it 'routes to #show' do
      expect(get: '/veterinarians/1').to route_to('veterinarians#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/veterinarians/1/edit').to route_to('veterinarians#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/veterinarians').to route_to('veterinarians#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/veterinarians/1').to route_to('veterinarians#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/veterinarians/1').to route_to('veterinarians#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/veterinarians/1').to route_to('veterinarians#destroy', id: '1')
    end

  end
end
