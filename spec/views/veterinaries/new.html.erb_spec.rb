require 'rails_helper'

RSpec.describe "veterinaries/new", type: :view do
  before(:each) do
    assign(:veterinary, Veterinary.new(
      :name => "MyString",
      :phone => "MyString",
      :email => "MyString"
    ))
  end

  it "renders new veterinary form" do
    render

    assert_select "form[action=?][method=?]", veterinaries_path, "post" do

      assert_select "input[name=?]", "veterinary[name]"

      assert_select "input[name=?]", "veterinary[phone]"

      assert_select "input[name=?]", "veterinary[email]"
    end
  end
end
