require 'rails_helper'

RSpec.describe 'veterinarians/show', type: :view do
  let(:vet1) { Veterinary.create(name: 'Help') }
  let(:vet2) { Veterinary.create(name: 'Hospital') }
  let(:veterinarian) do
    Veterinarian.create!(
      full_name: 'Full Name',
      phone: '261 666 5555',
      email: 'email@email.com'
    )
  end
  before(:each) do
    veterinarian.veterinaries = [vet1, vet2]
    @veterinarian = assign(:veterinarian, veterinarian)
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/nombre/)
    expect(rendered).to match(/261 666 5555/)
    expect(rendered).to match(/email@email.com/)
    expect(rendered).to match(/veterinarias/)
    expect(rendered).to match(/Help/)
    expect(rendered).to match(/Hospital/)
  end
end
