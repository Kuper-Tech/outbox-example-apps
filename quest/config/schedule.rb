# frozen_string_literal: true

# Schked schedule https://github.com/bibendi/schked
# WARNING: Keep your tasks as fast as you can. The best choise are Sidekiq jobs.

# Example task
# cron "*/1 * * * *", as: "UpdateMerchantStatusRequestsJob", timeout: "60s", overlap: false do
#  UpdateMerchantStatusRequestsJob.perform_async
# end
