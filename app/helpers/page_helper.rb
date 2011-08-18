require 'rdoc/markup/to_html'

module PageHelper
  def PageHelper.replace_spaces_in (path)
    path.gsub(/\s+/, '_')
  end

  class MediaWiki < WikiCloth::Parser
    link_for do |path, text|
      "<a href=\"/#{ PageHelper.replace_spaces_in path }\">#{text}</a>"
    end
  end
  
  MARKDOWN_OPTIONS = {
    :no_intra_emphasis   => true,
    :tables              => true,
    :fenced_code_blocks  => true,
    :autolink            => false,
    :strikethrough       => true,
    :lax_html_blocks     => false,
    :space_after_headers => false,
    :superscript         => false
  }
  
  def render_markdown (body)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, MARKDOWN_OPTIONS).render(body)
  end
  
  def render_textile (body)
    RedCloth.new(body).to_html
  end
  
  def render_rdoc (body)
    RDoc::Markup::ToHtml.new.convert(body)
  end
  
  def render_orgmode (body)
    Orgmode::Parser.new(body).to_html
  end
  
  def render_creole (body)
    Creole.creolize(body)
  end
  
  def render_mediawiki (body)
    MediaWiki.new(:data => body).to_html(:noedit => true)
  end

  def render_markup (markup, body)
    if    markup.is :markdown  then render_markdown(body).html_safe
    elsif markup.is :textile   then render_textile(body).html_safe
    elsif markup.is :rdoc      then render_rdoc(body).html_safe
    elsif markup.is :orgmode   then render_orgmode(body).html_safe
    elsif markup.is :creole    then render_creole(body).html_safe
    elsif markup.is :mediawiki then render_mediawiki(body).html_safe
    else
      body
    end
  end
end
