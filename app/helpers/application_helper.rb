module ApplicationHelper
  def active? path
    "active" if current_page? path
  end

  def favorite_text
    return @favorite_exists ? "Remove from favorites" : "Add to favorites"
  end

  def sortable(column, title, page)
    direction = define_sorting_direction(column)
    link_to title, path_for_sortable(column, direction, page), {
                                                                 :class => define_css_class(column),
                                                                 :remote => true
                                                                }
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

  private 

  def path_for_sortable(column, direction, page)
    if page == "index"
      dogs_path(request.parameters.merge({:sort => column, :direction => direction, :page => nil}))
    else
      my_list_path(request.parameters.merge({:sort => column, :direction => direction, :page => nil}))
    end
  end

  def define_css_class(column)
    if column == sort_column
      "flex-sm-fill text-sm-center nav-link dropdown-toggle active"
    else
      "flex-sm-fill text-sm-center nav-link"
    end
  end

  def define_sorting_direction(column)
    if column == sort_column && sort_direction == "asc"
      "desc"
    else 
      "asc"
    end
  end

  def dropup
    sort_direction == "desc" ? "dropup" : ""
  end
end