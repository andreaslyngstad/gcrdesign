xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Rubyonrails.no"
    xml.description "Blogginnlegg"
    xml.link formatted_posts_url(:rss)
    
    for post in @posts
      xml.item do
        xml.title article.title
        xml.description article.content
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link formatted_post_url(post, :rss)
        xml.guid formatted_post_url(post, :rss)
      end
    end
  end
end