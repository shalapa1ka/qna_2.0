# frozen_string_literal: true

every 1.days do
  runner 'DailyDigestJob.perform_now'
end
