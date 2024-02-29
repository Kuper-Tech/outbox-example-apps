# frozen_string_literal: true

module InboxImporters
  class OutboxTransportFactory
    def self.build(target:)
      "InboxImporters::#{target.camelize}Importer".constantize
    end
  end
end
