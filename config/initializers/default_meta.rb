DEFAULT_META = YAML.load_file(Rails.root.join("config/meta.yml"))
DEFAULT_META["twitter_account"] = ENV['TWITTER_ACCOUNT']
