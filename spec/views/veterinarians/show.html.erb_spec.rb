require 'rails_helper'

RSpec.describe "veterinarians/show", type: :view do
  before(:each) do
    @veterinarian = assign(:veterinarian, Veterinarian.create!(
      :full_name => "Full Name",
      :phone => "Phone",
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Full Name/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Email/)
  end
end
