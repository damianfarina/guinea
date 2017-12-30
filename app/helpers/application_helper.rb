module ApplicationHelper

  def nav_item_to(name = nil, options = nil, &block)
    options, name = name, block if block_given?
    options ||= {}

    url = url_for(options)
    link_html_options = {
      href: url,
      class: 'nav__link'
    }
    wrapper_html_options = {
      class: 'nav__item'
    }
    wrapper_html_options[:class] += ' nav__item--active' if current_page?(options)

    content_tag 'div'.freeze, wrapper_html_options do
      content_tag('a'.freeze, name || url, link_html_options, &block)
    end
  end
end
