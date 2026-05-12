class LinebotController < ApplicationController
  protect_from_forgery except: [:callback]

  def callback
    client = Line::Bot::V2::MessagingApi::ApiClient.new(
      channel_access_token: Rails.application.credentials.line[:channel_token]
    )

    events = params[:events] || []

    events.each do |event|
      line_user_id = event.dig("source", "userId")
      message = event.dig("message", "text")

      reply_text = "メッセージありがとうございます！"

      # =========================
      # LINE連携処理（シンプル版）
      # =========================
      if message == "連携"
        user = User.find_by(line_user_id: line_user_id)

        if user.present?
          reply_text = "すでに連携済みです！"
        else
          # 今ログイン中のユーザーと紐付ける前提（仮）
          user = User.first  # ←ここは後でログインユーザーに変更
          user.update(line_user_id: line_user_id) if user.present?

          reply_text = "連携完了しました！"
        end
      end

      request = Line::Bot::V2::MessagingApi::PushMessageRequest.new(
        to: line_user_id,
        messages: [
          { type: "text", text: reply_text }
        ]
      )

      client.push_message(push_message_request: request)
    end

    head :ok
  end
end