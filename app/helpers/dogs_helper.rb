module DogsHelper
  
  def sortable(column, title, page)
    link_to title, set_path_for_sorting(column, page), {
                                                         class: set_css_class(column),
                                                         remote: true
                                                        }
  end  

  def sort_column
    Dog.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  def set_dropup_css_class
    sort_direction == "desc" ? "dropup" : ""
  end 

  private 

    def set_path_for_sorting(column, page)
      page == "index" ? dogs_path(set_merged_params(column)) : my_list_path(set_merged_params(column))
    end 

    def set_merged_params column
      request.parameters.merge({sort: column, direction: set_sorting_direction(column)})
    end 

    def set_sorting_direction(column)
      ((column == sort_column) && (sort_direction == "asc")) ? "desc" : "asc"
    end  

    def set_css_class(column)
      "flex-sm-fill text-sm-center nav-link#{" dropdown-toggle active" if column == sort_column}"
    end   
end
