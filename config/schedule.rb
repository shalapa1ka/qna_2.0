# frozen_string_literal: true

every 1.minute do
  runner 'DailyDigestJob.perform_now'
end
