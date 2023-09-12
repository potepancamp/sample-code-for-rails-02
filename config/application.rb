require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AirbnbDemo
  class Application < Rails::Application
    config.load_defaults 6.0

    config.i18n.default_locale = :ja
    config.time_zone = 'Asia/Tokyo'

    # form_withのデフォルトを local: true に設定するため
    config.action_view.form_with_generates_remote_forms = false

    # field_with_errorsのタグを読み込まないようにするため
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }
  end
end
