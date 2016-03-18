module GitHub
  def stub_github_request
    stub_request(:get, /.*api.github.com.*/).
      to_return(body: fixture_load('github', 'pulls.json'),
                headers: { 'Content-Type' => 'application/json' })
  end
end
