xml.instruct!
xml.rss version: '2.0' do
  xml.channel do
    xml.title @repository.title
    xml.description @repository.description
    xml.link @repository.link
    xml.pubDate @repository.created_at

    @repository.pull_requests.each do |pr|
      xml.item do
        xml.title pr.title
        xml.description pr.description
        xml.link pr.link
        xml.pubDate pr.created_at
        xml.guid pr.guid
      end
    end
  end
end
