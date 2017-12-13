require 'rails_helper'

RSpec.describe 'veterinarians/index', type: :view do
  before(:each) do
    assign(:veterinarians, [
      Veterinarian.create!(
        full_name: 'Full Name 1',
        phone: '261 333 4444',
        email: 'email1@email.com'
      ),
      Veterinarian.create!(
        full_name: 'Full Name 2',
        phone: '261 444 5555',
        email: 'email2@email.com'
      )
    ])
  end

  it 'renders a list of veterinarians' do
    render
    assert_select 'tr>td', text: 'Full Name 1', count: 1
    assert_select 'tr>td', text: '261 333 4444', count: 1
    assert_select 'tr>td', text: 'email1@email.com', count: 1
    assert_select 'tr>td', text: 'Full Name 2', count: 1
    assert_select 'tr>td', text: '261 444 5555', count: 1
    assert_select 'tr>td', text: 'email2@email.com', count: 1
  end
end
