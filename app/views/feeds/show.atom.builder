atom_feed do |feed|
  feed.title repository.descriptive_title
  feed.subtitle repository.description
  feed.updated repository.created_at
  feed.author do |author|
    author.name repository.owner
  end

  repository.presented_pull_requests.each do |pr|
    feed.tag!(:entry) do |entry|
      entry.title pr.title
      entry.content(pr.html_description, type: :html)
      entry.link(href: pr.link, rel: :alternate)
      entry.published pr.created_at
      entry.updated pr.created_at
      entry.id pr.link
      entry.author do |author|
        author.name pr.author
      end
    end
  end
end
