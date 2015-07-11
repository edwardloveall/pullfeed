class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from PullRequestFetcher::RepositoryNotFound do |_|
    render file: Rails.root.join('/public/404.html'),
           status: :not_found,
           content_type: Mime::Type.lookup_by_extension(:html)
  end
end
