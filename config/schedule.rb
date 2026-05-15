# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end
set :output, { error: "log/cron_error.log", standard: "log/cron.log" }
set :environment, "development"

job_type :rbenv_rake,
  'export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH" && ' \
  'eval "$(rbenv init -)" && ' \
  'cd :path && bundle exec rake :task'

every 1.minute do
  rbenv_rake "line:notify"
end
# Learn more: http://github.com/javan/whenever
