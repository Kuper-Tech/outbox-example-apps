# frozen_string_literal: true

class ApplicationEncoder
  extend Dry::Initializer

  def encode
    message_class.new(data).to_proto
  end

  private

  def data
    raise NotimplementedError
  end

  def encoder
    @encoder ||= ProtobufEncoder.new(message_class: message_class)
  end

  def encode_time(time)
    return unless time
    Google::Protobuf::Timestamp.new(seconds: time.to_i, nanos: time.nsec)
  end

  def encode_money(value, currency = "RUB")
    units, nanos = BigDecimal(value.to_s).to_s("F").split(".")
    values = [
      currency,
      units.to_i,
      nanos.ljust(2, "0").to_i
    ].flatten

    %i[currency_code units nanos].zip(values).to_h
  end
end
