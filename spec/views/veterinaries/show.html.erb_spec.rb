require 'rails_helper'

RSpec.describe "veterinaries/show", type: :view do
  before(:each) do
    @veterinary = assign(:veterinary, Veterinary.create!(
      :name => "Name",
      :phone => "Phone",
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Email/)
  end
end
