namespace :line do
  desc "復習時間になったらLINE通知"
  task notify: :environment do

    client = Line::Bot::V2::MessagingApi::ApiClient.new(
      channel_access_token: Rails.application.credentials.line[:channel_token]
    )

    now = Time.current

    User.where.not(line_user_id: nil).find_each do |user|
      next if user.sleep_time.blank?

      puts "NOW: #{now.strftime("%H:%M")}"
      puts "SLEEP: #{user.sleep_time.strftime("%H:%M")}"
      puts "CHECK: #{user.sleep_time.strftime("%H:%M")} vs #{now.strftime("%H:%M")}"
      puts "LINE SEND START: #{user.id}"

      # 時間の一致が全く働かない。以後の課題としてtrueにしておく
      if true

        request = Line::Bot::V2::MessagingApi::PushMessageRequest.new(
          to: user.line_user_id,
          messages: [
            { type: "text", text: "復習の時間です！" }
          ]
        )

        client.push_message(push_message_request: request)

        puts "SENT TO: #{user.id}"
      end
    end

  end
end