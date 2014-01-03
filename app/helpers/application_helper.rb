module ApplicationHelper

  def link_to_selected(*arg, &block)
    if current_page?(arg[0])
      options = arg.extract_options!
      options[:class] += ' selected'
      arg << options
    end

    link_to(*arg, &block)
  end

end
