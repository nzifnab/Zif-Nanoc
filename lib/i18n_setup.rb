require 'i18n'

I18n.load_path += Dir[File.join(File.dirname(__FILE__), 'locale', '*.{rb,yml}').to_s]
I18n.default_locale = :en


# Fallback to the default if a localization for a specific value isn't set.
I18n.backend.class.send(:include, I18n::Backend::Fallbacks)

(I18n.available_locales - [I18n.default_locale]).each do |locale|
  I18n.fallbacks.merge(locale => I18n.default_locale)
end

module I18nHelper
  # Gives a warning if the specified translation string doesn't exist.  Drop the .tap{} block
  # if you don't want this warning.
  def translate(*args)
    I18n.translate(*args).tap do |translation|
      puts "WARNING:  #{translation}" if translation =~ /translation missing/
    end
  end

  alias_method :t, :translate
end

include I18nHelper