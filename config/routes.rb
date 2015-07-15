Rails.application.routes.draw do
  get 'feeds/:owner/:repo',
      to: 'feeds#show',
      as: :feed,
      constraints: { repo: /[^\/]+/ },
      defaults: { format: :atom }
  get 'humans.txt', to: 'high_voltage/pages#show', id: 'humans'
end
