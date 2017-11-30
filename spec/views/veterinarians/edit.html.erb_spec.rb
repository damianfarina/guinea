require 'rails_helper'

RSpec.describe "veterinarians/edit", type: :view do
  before(:each) do
    @veterinarian = assign(:veterinarian, Veterinarian.create!(
      :full_name => "MyString",
      :phone => "MyString",
      :email => "MyString"
    ))
  end

  it "renders the edit veterinarian form" do
    render

    assert_select "form[action=?][method=?]", veterinarian_path(@veterinarian), "post" do

      assert_select "input[name=?]", "veterinarian[full_name]"

      assert_select "input[name=?]", "veterinarian[phone]"

      assert_select "input[name=?]", "veterinarian[email]"
    end
  end
end
