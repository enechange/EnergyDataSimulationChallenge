module ApplicationHelper
  def sort_link(column, options = {})
    direction = (column.to_s == params[:sort] && params[:direction] == 'asc') ? 'desc' : 'asc'
    sort_mark = direction == 'asc' ? '▼' : '▲'
    sort_params = if options[:with_params]
                    params.merge({:sort => column, :direction => direction})
                  else
                    {:sort => column, :direction => direction}
                  end
    link_to sort_mark, sort_params
  end
end
