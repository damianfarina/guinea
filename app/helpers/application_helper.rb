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
    path = request.original_fullpath
    wrapper_html_options[:class] += ' nav__item--active' unless path.match(/^#{Regexp.escape(url).chomp('/')}(\/.*|\?.*)?$/).blank?

    tag.div wrapper_html_options do
      tag.a((name || url), link_html_options, &block)
    end
  end
end
