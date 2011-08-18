module PageHelper
  def render_markup (markup, body)
    if markup.is :markdown
      # TODO
    elsif markup.is :textile
      # TODO
    elsif markup.is :rdoc
      # TODO
    elsif markup.is :orgmode
      # TODO
    elsif markup.is :creole
      # TODO
    elsif markup.is :mediawiki
      # TODO
    end
  end
end
