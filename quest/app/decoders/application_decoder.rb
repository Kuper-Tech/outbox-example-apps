# frozen_string_literal: true

class ApplicationDecoder
  extend Dry::Initializer

  param :data
  option :message_klass

  def decode
    message_klass.decode(data).to_h
  end

  private

  def decode_money(value)
    return unless value&.units
    BigDecimal("#{value.units}.#{value.nanos}")
  end

  def decode_time(value)
    return unless value&.seconds
    Time.zone.at(value.seconds, value.nanos, :nsec)
  end
end
