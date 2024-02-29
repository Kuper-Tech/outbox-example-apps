# frozen_string_literal: true

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{__dir__}/log/.irb_history"
IRB.conf[:USE_AUTOCOMPLETE] = false

ENV["XDG_DATA_HOME"] ||= "#{__dir__}/tmp"
