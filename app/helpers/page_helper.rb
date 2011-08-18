require 'rdoc/markup/to_html'

module PageHelper
  def PageHelper.replace_spaces_in (path)
    path.gsub(/\s+/, '_')
  end

  class MarkupRenderer
    def initialize (helper, markup, text)
      @helper = helper
      @markup = markup
      @text   = text
    end
    
    def to_s
      if respond_to? @markup.to_sym
        send @markup.to_sym
      else
        "<pre>#{ h @text }</pre>"
      end
    end
  
  protected
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
    
    def markdown
      Redcarpet::Markdown.new(Redcarpet::Render::HTML, MARKDOWN_OPTIONS).render(@text)
    end
    
    def textile
      RedCloth.new(@text).to_html
    end
    
    def rdoc
      RDoc::Markup::ToHtml.new.convert(@text)
    end
    
    def orgmode
      Orgmode::Parser.new(@text).to_html
    end
    
    def creole
      Creole.creolize(@text)
    end
    
    class MediaWiki < WikiCloth::Parser
      link_for do |path, text|
        "<a href=\"/#{ PageHelper.replace_spaces_in path }\">#{text}</a>"
      end
    end
    
    def add_mathjax_script
      @helper.content_for :mathjax do
        mathjax = <<-MATHJAX
          <script type="text/javascript"
            src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
          </script>
        MATHJAX
        mathjax.html_safe
      end
    end
    
    def contains_math_tag?
      @text =~ /\<math\>.*?\<\/math\>/
    end
    
    def replace_math_tag!
      @text.gsub! /\<math\>/, "\\("
      @text.gsub! /\<\/math\>/, "\\)"
    end
    
    def mediawiki
      if contains_math_tag?
        replace_math_tag!
        add_mathjax_script
      end
      MediaWiki.new(:data => @text).to_html(:noedit => true)
    end
  end

  def render_markup (markup, text)
    MarkupRenderer.new(self, markup, text).to_s
  end
end
