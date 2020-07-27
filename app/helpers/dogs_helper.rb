module DogsHelper
  
  def sortable(column, title, page)
    link_to title, set_path_for_sorting(column, page), {
                                                         class: set_css_class(column),
                                                         remote: true
                                                        }
  end  

  private 

    def set_path_for_sorting(column, page)
      merged_params = request.parameters.merge({sort: column, direction: set_sorting_direction(column)})
      page == "index" ? dogs_path(merged_params) : my_list_path(merged_params)
    end  

    def set_sorting_direction(column)
      ((column == sort_column) && (sort_direction == "asc")) ? "desc" : "asc"
    end  

    def set_css_class(column)
      "flex-sm-fill text-sm-center nav-link#{" dropdown-toggle active" if column == sort_column}"
    end

    def set_dropup_css_class
      sort_direction == "desc" ? "dropup" : ""
    end

    def sort_column
      Dog.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end
end
