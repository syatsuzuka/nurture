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
end
