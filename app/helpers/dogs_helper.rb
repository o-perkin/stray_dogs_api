module DogsHelper
  
  def sortable(column, title, page)
    direction = define_sorting_direction(column)
    link_to title, define_path_for_sortable(column, direction, page), {
                                                                        class: define_css_class(column),
                                                                        remote: true
                                                                      }
  end

  private 

    def define_path_for_sortable(column, direction, page)
      merged_params = request.parameters.merge({sort: column, direction: direction, page: nil})
      if page == "index"
        dogs_path(merged_params)
      else
        my_list_path(merged_params)
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

    def define_dropup_css_class
      sort_direction == "desc" ? "dropup" : ""
    end

    def sort_column
      Dog.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end
end
