module LayoutHelper
  def title(page_title, show_title = true)
    @content_for_title = page_title.to_s
  end
end