module ApplicationHelper
  # Returns the full title
  def full_title page_title
    base_title = t("base_title")
    page_title.blank? ? base_title : [page_title, base_title].join(" | ")
  end

  def find_followed_by_user_id user
    current_user.active_relationships.find_by followed_id: user.id
  end
end
