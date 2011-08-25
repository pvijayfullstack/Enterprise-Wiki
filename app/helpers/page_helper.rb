require 'rdoc/markup/to_html'

module PageHelper
  def PageHelper.slugify (path)
    path.to_s.strip.downcase.gsub(/\s+/, '_')
  end

  class MarkupRenderer
    def initialize (helper, markup, text)
      @helper = helper
      @markup = markup
      @text   = text
    end
    
    def to_s
      syntax_highlighter render
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
      :superscript         => false,
    }
    
    def render
      if respond_to? @markup.to_sym
        send @markup.to_sym
      else
        "<pre>#{ h @text }</pre>"
      end
    end
    
    def syntax_highlighter(html)
      doc = Nokogiri::HTML(html)
      doc.search("//pre/code[@class]").each do |code|
        code.parent.replace Albino.colorize(code.text.rstrip, code[:class])
      end
      doc.css('body').inner_html.to_s
    end
    
    def markdown
      html = Redcarpet::Markdown.new(Redcarpet::Render::HTML, MARKDOWN_OPTIONS).render(@text)
      if contains_math_tag?
        replace_math_tag! html
        add_mathjax_script
      end
      html
    end
    
    def textile
      html = RedCloth.new(@text).to_html
      if contains_math_tag?
        replace_math_tag! html
        add_mathjax_script
      end
      html
    end
    
    def rdoc
      if contains_math_tag?
        # replace \ with \\ between <math> and </math>
        i = j = 0
        while i = @text.index("<math>", j)
          j = @text.index("</math>", i)
          @text[i..j] = @text[i..j].gsub(/\\/, "\\\\\\\\")
        end
        replace_math_tag! @text, "\\\\\\(", "\\\\\\)"
        add_mathjax_script
      end
      RDoc::Markup::ToHtml.new.convert(@text)
    end
    
    # Orgmode comes with MathJax options but we still provide the <math> format
    def orgmode
      if contains_math_tag?
        replace_math_tag! @text
        add_mathjax_script
      end
      Orgmode::Parser.new(@text).to_html
    end
    
    def creole
      if contains_math_tag?
        replace_math_tag! @text
        add_mathjax_script
      end
      Creole.creolize(@text)
    end
    
    class MediaWiki < WikiCloth::Parser
      link_for do |path, text|
        "<a href=\"/#{ PageHelper.slugify path }\">#{text}</a>"
      end
    end
    
    def mediawiki
      if contains_math_tag?
        replace_math_tag! @text
        add_mathjax_script
      end
      MediaWiki.new(:data => @text).to_html(:noedit => true)
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
    
    def replace_math_tag! (text, left = "\\(", right = "\\)")
      text.gsub! /\<math\>/, left
      text.gsub! /\<\/math\>/, right
    end
  end

  def render_markup (markup, text)
    MarkupRenderer.new(self, markup, text).to_s
  end
end
