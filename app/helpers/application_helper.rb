module Phogo
  module Helpers
    # writes a CSRF meta tag to protect againts CSRF requests
    def csrf_tag(env)
      Rack::Csrf.tag(env)
    end

    def current_page?(path='')
      request.path_info == path
    end

    def nav_link(name, path)
      options = 'class="active"' if current_page?(path)
      "<a href=\"#{path}\" #{options}>#{name}</a>"
    end
  end
end
