class I18n::Backend::Database < I18n::Backend::ActiveRecord

  def translate(locale, key, options = {})
    begin
      super
    rescue I18n::MissingTranslationData => e
      key = key.to_s
      options.each do |nm,value|
        key.gsub!("{{#{nm.to_s}}}", value.to_s)
      end

      return key
    end
  end

end
