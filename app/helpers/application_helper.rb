module ApplicationHelper

  def active? path
    "active" if current_page? path
  end

  def copyright_generator
    PerkinViewTool::Renderer.copyright 'Alex Perkin', 'All rights reserved'
  end
end