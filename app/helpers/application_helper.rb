module ApplicationHelper
  def active? path
    "active" if current_page? path
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "flex-sm-fill text-sm-center nav-link active dropdown-toggle" : "flex-sm-fill text-sm-center nav-link"
    active_class = column == "created_at" && sort_column == "created_at" ? "active" : ""
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class + " " + active_class}
  end

  def dropup
    sort_direction == "desc" ? "dropup" : ""
  end
end
