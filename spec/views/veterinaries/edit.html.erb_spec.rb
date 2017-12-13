require 'rails_helper'

RSpec.describe 'veterinaries/edit', type: :view do
  before(:each) do
    @veterinary = assign(:veterinary, Veterinary.create!(
      name: 'Damián',
      phone: '261 333 4455',
      email: ''
    ))
  end

  it 'renders the edit veterinary form' do
    render

    assert_select 'form[action=?][method=?]', veterinary_path(@veterinary), 'post' do
      assert_select 'input[name=?]', 'veterinary[name]'
      assert_select 'input[name=?]', 'veterinary[phone]'
      assert_select 'input[name=?]', 'veterinary[email]'
    end
  end
end
