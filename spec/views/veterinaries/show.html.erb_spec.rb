require 'rails_helper'

RSpec.describe "veterinaries/show", type: :view do
  let(:vet1) { Veterinarian.create(name: 'Mariano') }
  let(:vet2) { Veterinarian.create(name: 'Mika') }
  let(:veterinary) do
    Veterinary.create!(
      name: 'Name',
      phone: '261 444 5678',
      email: 'email@email.com'
    )
  end

  before(:each) do
    veterinary.veterinarians = [vet1, vet2]
    @veterinary = assign(:veterinary, veterinary)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/261 444 5678/)
    expect(rendered).to match(/email@email.com/)
    expect(rendered).to match(/Veterinarians/)
    expect(rendered).to match(/Mariano/)
    expect(rendered).to match(/Mika/)
  end
end
