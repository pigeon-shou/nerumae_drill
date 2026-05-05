module ApplicationHelper
  def page_title
  case controller_name
  when "learnings"
    case action_name
    when "index"
      "ドリル"
    when "new"
      "新しく覚える"
    when "show"
      "詳細"
    else
      "ねるまえドリル"
    end
  when "sessions"
    "ログイン"
  when "registrations"
    "新規登録"
  else
    "ねるまえドリル"
  end
end
end
