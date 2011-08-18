require "rdoc/markup/to_html"

module PageHelper
  class MediaWiki < WikiCloth::Parser
    link_for do |path, text|
      "<a href=\"/#{ path.gsub(/\s+/, '_') }\">#{text}</a>"
    end
  end

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
      RedCloth.new(body).to_html
    elsif markup.is :rdoc
      RDoc::Markup::ToHtml.new.convert(body)
    elsif markup.is :orgmode
      Orgmode::Parser.new(body).to_html
    elsif markup.is :creole
      Creole.creolize(body)
    elsif markup.is :mediawiki
      MediaWiki.new(:data => body).to_html(:noedit => true)
    else
      # TODO escape as plain text
    end
  end
end
