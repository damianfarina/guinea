require 'rails_helper'

RSpec.describe "veterinaries/index", type: :view do
  before(:each) do
    assign(:veterinaries, [
      Veterinary.create!(
        :name => "Name",
        :phone => "Phone",
        :email => "Email"
      ),
      Veterinary.create!(
        :name => "Name",
        :phone => "Phone",
        :email => "Email"
      )
    ])
  end

  it "renders a list of veterinaries" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end
