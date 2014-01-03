module ApplicationHelper

  def link_to_selected(*arg, &block)
    if current_page?(arg[0]) || at_track?(arg[0]) || at_classroom?(arg[0])
      options = arg.extract_options!
      options[:class] += ' selected'
      arg << options
    end

    link_to(*arg, &block)
  end

  def at_classroom?(path)
    path.match(/classrooms$/) && (params[:controller] == 'classrooms' || params[:controller] == 'invitations')
  end

  def at_track?(path)
    path.match(/tracks$/) && (params[:controller] == 'tracks' || params[:controller] == 'checkpoints')
  end

end
