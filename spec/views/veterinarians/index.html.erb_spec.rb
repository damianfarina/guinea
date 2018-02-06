require 'rails_helper'

RSpec.describe 'veterinarians/index', type: :view do
  let(:veterinaries) { create_list :veterinary, 2 }
  let(:veterinarian1) do
    create :veterinarian,
      full_name: 'Name1',
      phone: '261 333 4444',
      email: 'email1@email.com',
      veterinaries: veterinaries
  end
  let(:veterinarian2) do
    create :veterinarian,
      full_name: 'Name2',
      phone: '261 444 5555',
      email: 'email2@email.com'
  end

  before(:each) do
    assign(:veterinarians, [veterinarian1, veterinarian2])
  end

  it 'renders a list of admissions' do
    render
    assert_select '.veterinarian', count: 2
    assert_select '.veterinarians' do
      assert_select '.veterinarian:first' do
        assert_select "a.show[href='#{veterinarian_path(veterinarian1)}']", count: 1
        assert_select '.full-name', text: veterinarian1.full_name, count: 1
        assert_select '.phone', text: veterinarian1.phone, count: 1
        assert_select '.email', text: veterinarian1.email, count: 1
        assert_select '.veterinaries' do
          assert_select '.veterinary', veterinaries.first.name
          assert_select '.veterinary', veterinaries.second.name
        end
      end
    end
  end
end
