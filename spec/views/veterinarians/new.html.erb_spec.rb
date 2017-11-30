require 'rails_helper'

RSpec.describe "veterinarians/new", type: :view do
  before(:each) do
    assign(:veterinarian, Veterinarian.new(
      :full_name => "MyString",
      :phone => "MyString",
      :email => "MyString"
    ))
  end

  it "renders new veterinarian form" do
    render

    assert_select "form[action=?][method=?]", veterinarians_path, "post" do

      assert_select "input[name=?]", "veterinarian[full_name]"

      assert_select "input[name=?]", "veterinarian[phone]"

      assert_select "input[name=?]", "veterinarian[email]"
    end
  end
end
