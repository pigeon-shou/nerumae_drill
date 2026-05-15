namespace :line do
  desc "復習時間になったらLINE通知を送る"
  task notify: :environment do
    client = Line::Bot::V2::MessagingApi::ApiClient.new(
      channel_access_token: Rails.application.credentials.line[:channel_token]
    )

    now = Time.current
    today = now.to_date

    User.where.not(line_user_id: nil).find_each do |user|
      # 睡眠時間が未設定ならスキップ
      next if user.sleep_time.blank?

      # 今日すでに通知済みならスキップ
      next if user.last_notified_at&.to_date == today

      # ユーザーの指定時刻を今日の日時として組み立てる
      notify_time = now.change(
        hour: user.sleep_time.hour,
        min:  user.sleep_time.min,
        sec:  0
      )

      # 指定時刻の±5分以内でなければスキップ
      next unless now.between?(notify_time - 5.minutes, notify_time + 5.minutes)

      # 通知を送る
      client.push_message(
        push_message_request: Line::Bot::V2::MessagingApi::PushMessageRequest.new(
          to: user.line_user_id,
          messages: [{ type: "text", text: "復習の時間です！" }]
        )
      )

      # 今日通知済みとして記録
      user.update!(last_notified_at: today)
    end
  end
end