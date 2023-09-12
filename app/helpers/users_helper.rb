module UsersHelper
  def user_icon(user)
    user.image.presence || "common/default-avatar.png"
  end

  def current_pages?(prefixes)
    prefixes.any? { |prefix| current_page?(send("#{prefix}_path")) }
  end

  def active_class_if_account_page
    "active" if current_pages?(%w[users_account edit_user_registration])
  end

  def active_class_if_profile_page
    "active" if current_pages?(%w[users_profile edit_users_profile])
  end
end
