module ApplicationHelper
  # Returns the full title
  def full_title page_title
    base_title = t("base_title")
    page_title.blank? ? base_title : [page_title, base_title].join(" | ")
  end
end
