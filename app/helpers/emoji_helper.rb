# rubocop:disable all
module EmojiHelper
  def emojify(content)
    h(content).to_str.gsub(/:([\w+-]+):/) do |match|
      if emoji = Emoji.find_by_alias($1)
        path = "/images/emoji/#{emoji.image_filename}"
        %(<img alt="#$1" src="#{path}" style="vertical-align:middle" width="20" height="20" />)
      else
        match
      end
    end.html_safe if content.present?
  end
end
# rubocop:enable all
