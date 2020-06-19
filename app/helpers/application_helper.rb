module ApplicationHelper
  def active? path
    "active" if current_page? path
  end

  def favorite_text
    return @favorite_exists ? "Remove from favorites" : "Add to favorites"
  end

  def sortable(column, title = nil, page)
    title ||= column.titleize
    css_class = column == sort_column ? "flex-sm-fill text-sm-center nav-link active dropdown-toggle" : "flex-sm-fill text-sm-center nav-link"
    active_class = column == "created_at" && sort_column == "created_at" ? "active" : ""
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, path_for_sortable(column, direction, title, page), {:class => css_class + " " + active_class, :remote => true}
  end

  def path_for_sortable(column, direction, title, page)
    if page == "index"
      dogs_path(request.parameters.merge({:sort => column, :direction => direction, :page => nil}))
    else
      my_list_path(request.parameters.merge({:sort => column, :direction => direction, :page => nil}))
    end
  end

  def dropup
    sort_direction == "desc" ? "dropup" : ""
  end

  def copyright_generator
    PerkinViewTool::Renderer.copyright 'Alex Perkin', 'All rights reserved'
  end

  def access_to_editing(page)
    if page == "index"
      logged_in?(:site_admin)
    else
      true
    end
  end
end
