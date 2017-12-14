require 'rails_helper'

RSpec.describe VeterinariesController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: '/veterinaries').to route_to('veterinaries#index')
    end

    it 'routes to #new' do
      expect(get: '/veterinaries/new').to route_to('veterinaries#new')
    end

    it 'routes to #show' do
      expect(get: '/veterinaries/1').to route_to('veterinaries#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/veterinaries/1/edit').to route_to('veterinaries#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/veterinaries').to route_to('veterinaries#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/veterinaries/1').to route_to('veterinaries#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/veterinaries/1').to route_to('veterinaries#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/veterinaries/1').to route_to('veterinaries#destroy', id: '1')
    end

  end
end
