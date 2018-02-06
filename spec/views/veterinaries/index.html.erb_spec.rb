require 'rails_helper'

RSpec.describe 'veterinaries/index', type: :view do
  let(:veterinarians) { create_list :veterinarian, 2 }
  let(:veterinary1) do
    Veterinary.create!(
      name: 'Name1',
      phone: '261 555 6677',
      email: 'email1@email.com',
      veterinarians: veterinarians
    )
  end
  let(:veterinary2) do
    Veterinary.create!(
      name: 'Name2',
      phone: '261 333 4545',
      email: 'email2@email.com'
    )
  end

  before(:each) do
    assign(:veterinaries, [veterinary1, veterinary2])
  end

  it 'renders a list of veterinaries' do
    render
    assert_select '.veterinary', count: 2
    assert_select '.veterinaries' do
      assert_select '.veterinary:first' do
        assert_select "a.show[href='#{veterinary_path(veterinary1)}']", count: 1
        assert_select '.name', text: veterinary1.name, count: 1
        assert_select '.phone', text: veterinary1.phone, count: 1
        assert_select '.email', text: veterinary1.email, count: 1
        assert_select '.veterinarians' do
          assert_select '.veterinarian', veterinarians.first.name
          assert_select '.veterinarian', veterinarians.second.name
        end
      end
    end
  end
end
