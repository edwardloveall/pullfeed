Rails.application.routes.draw do
  get 'feeds/:owner/:repo', to: 'feeds#show', as: :feed, defaults: { format: 'rss' }
end
