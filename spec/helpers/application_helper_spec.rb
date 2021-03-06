require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  it 'should generate a navigation link' do
    with_custom_content = helper.nav_item_to(veterinarians_path) {
      content_tag(:p, 'hey')
    }
    expect(with_custom_content).to include('<p>hey</p>')
    expect(with_custom_content).to include('nav__link')
    expect(with_custom_content).to include('nav__item')
    expect(with_custom_content).not_to include('nav__item--active')

    expect(helper.nav_item_to('Admissions', admissions_path)).not_to include('nav__item--active')

    allow(helper).to receive(:request).and_return double(original_fullpath: '/main/nested')
    expect(helper.nav_item_to('Main Route', '/main')).to include('nav__item--active')
  end
end
