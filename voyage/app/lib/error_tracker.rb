# frozen_string_literal: true

module ErrorTracker
  LEVELS = %i[info error debug warning fatal].freeze

  class << self
    LEVELS.each do |level|
      define_method(level) do |message, **args|
        notify(message, level: level, **args)
      end
    end

    def notify(message, level: :error, tags: {}, **args)
      Sentry.with_scope do |scope|
        scope.set_tags(tags)

        case message
        when String
          Sentry.capture_message(message, level: level, extra: args)
        else
          Sentry.capture_exception(message, level: level, extra: args)
        end
      end
    end
  end
end
