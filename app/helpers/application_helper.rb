module ApplicationHelper
  # writes a CSRF meta tag to protect againts CSRF requests
  def csrf_tag(env)
    Rack::Csrf.tag(env)
  end
end
