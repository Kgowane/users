module UsersHelper
  def header(text)
    content_for(:header) { text.to_s }
  end

  def find_user_name user_id
    User.find(user_id).full_name
  end
end
