module ChatHelper

  def youtube_link?(input)
    if input.include? "www.youtube.com"
      true
    else
      false
    end
  end

  def url_clean(input)
    return input.match(URI.regexp).to_s
  end

  def url?(input)
    input == URI.regexp
  end


  def text_or_youtube(message)
    if youtube_link?(message.content)
      YouTubeAddy.youtube_embed_url(url_clean(message.content), "100%", "100%").gsub("http", "https").html_safe

    else
      message.content
    end
  end

  def user_role_style(message)
    if message.user.role == "tutor"
      "bg-success"
    else
      "bg-dark"
    end
  end

end
