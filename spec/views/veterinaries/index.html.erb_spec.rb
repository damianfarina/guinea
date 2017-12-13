require 'rails_helper'

RSpec.describe 'veterinaries/index', type: :view do
  before(:each) do
    assign(:veterinaries, [
      Veterinary.create!(
        name: 'Name1',
        phone: '261 555 6677',
        email: 'email1@email.com'
      ),
      Veterinary.create!(
        name: 'Name2',
        phone: '261 333 4545',
        email: 'email2@email.com'
      )
    ])
  end

  it 'renders a list of veterinaries' do
    render
    assert_select 'tr>td', text: 'Name1', count: 1
    assert_select 'tr>td', text: '261 555 6677', count: 1
    assert_select 'tr>td', text: 'email1@email.com', count: 1
    assert_select 'tr>td', text: 'Name2', count: 1
    assert_select 'tr>td', text: '261 333 4545', count: 1
    assert_select 'tr>td', text: 'email2@email.com', count: 1
  end
end
