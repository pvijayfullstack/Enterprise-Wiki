module PageHelper
  def render_markup (markup, body)
    if markup.is :markdown
      Redcarpet::Markdown.new(Redcarpet::Render::HTML,
          :no_intra_emphasis   => true,
          :tables              => true,
          :fenced_code_blocks  => true,
          :autolink            => false,
          :strikethrough       => true,
          :lax_html_blocks     => false,
          :space_after_headers => false,
          :superscript         => false).render(body)
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
