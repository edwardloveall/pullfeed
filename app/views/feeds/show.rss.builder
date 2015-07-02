xml.instruct!
xml.rss version: '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' do
  xml.channel do
    xml.title repository.descriptive_title
    xml.description repository.description
    xml.link repository.link
    xml.pubDate repository.created_at.rfc822
    xml.lastBuildDate repository.created_at.rfc822
    xml.tag! 'atom:link',
             href: feed_url(owner: repository.owner, repo: repository.title),
             rel: 'self',
             type: 'application/rss+xml'

    repository.presented_pull_requests.each do |pr|
      xml.item do
        xml.author do
          xml.name pr.author
        end
        xml.title pr.title
        xml.description pr.html_description
        xml.link pr.link
        xml.pubDate pr.created_at.rfc822
        xml.guid pr.guid
      end
    end
  end
end
