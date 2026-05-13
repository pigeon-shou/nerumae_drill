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
set :output, "log/cron.log"
set :environment, "development" # 本番なら production


every 1.minute do
  command "cd /Users/murph/nerumae_drill && /bin/bash -l -c 'bundle _2.4.1_ exec rake line:notify'"
end
# Learn more: http://github.com/javan/whenever
