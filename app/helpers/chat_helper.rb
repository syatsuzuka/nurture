module ChatHelper

  def youtube_link?(data)
    if data.include? "www.youtube.com"
      true
    else
      false
    end
  end

  def youtube_url_clean(data)
    return data.match(URI.regexp).to_s
  end

  def text_or_youtube(message)
    if youtube_link?(message.content)
      YouTubeAddy.youtube_embed_url(youtube_url_clean(message.content),420,315).html_safe
    else
      message.content
    end
  end

end
