module Phogo
  module Helpers
    # writes a CSRF meta tag to protect againts CSRF requests
    def csrf_tag
      Rack::Csrf.tag(env)
    end

    def current_page?(path='')
      request.path_info == path
    end

    def abs_path(path)
      "#{request.base_url}#{path}"
    end

    def nav_link(name, path)
      options = 'class="active"' if current_page?(path)
      "<a href=\"#{path}\" #{options}>#{name}</a>"
    end

    def mail_to(email_address)
      email_address_encoded = 'mailto:'.unpack('C*').map { |c|
        sprintf("&#%d;", c)
      }.join + email_address.unpack('C*').map { |c|
        symbol = c.chr
        symbol =~ /\w/ ? sprintf("%%%x", c) : symbol
      }.join
      email_address_text = email_address.gsub(/@/, '<i class="fa fa-at"></i>')
      "<a href=\"#{email_address_encoded}\">#{email_address_text}</a>"
    end
  end
end
