require "jekyll_figure/version"

module Jekyll

  # Creates a Liquid figure tag. The figure tag should take this form:
  #
  #   {% figure filename svg,png,pdf 'Your caption here' %}
  #
  # The first value is the filename, which should be shared across every 
  # format of the figure. The second value is a comma-separated list of 
  # extensions for the filename. The third value is a quoted caption. The tag 
  # will produce an img tag for the first file format in the list of 
  # extensions. It will include a caption with links to all the figure 
  # formats. If the figures directory is set in _config.yml, then the image 
  # and the links will point there.
  class FigureTag < Liquid::Tag 

    require "shellwords"

    def initialize(tag_name, text, tokens)
      super
      @text = text.shellsplit
    end

    def render(context)
      # If the figures directory is not defined, set dir to site root
      if defined? context.registers[:site].config["figures"]["dir"] 
        dir = context.registers[:site].config["figures"]["dir"]
      else
        dir = ""
      end

      filename   = @text[0]
      extensions = @text[1].split(",")
      caption    = @text[2]
      img_src    = "#{dir}/#{filename}.#{extensions.first}"
      downloads  = proc {
        d = []
        extensions.each do |ext|
          d.push %Q{<a href="#{dir}/#{filename}.#{ext}">#{ext.upcase}</a>,}
        end
        d.join(" ")[0..-2]
      }

      "<figure>"                                                         +
      "<a href='#{img_src}'><img src='#{img_src}' alt='#{caption}'></a>" +
      "<figcaption>"                                                     +
      "#{caption} (#{downloads.call})"                                   +
      "</figcaption>"                                                    +
      "</figure>"

    end

  end
end

Liquid::Template.register_tag('figure', Jekyll::FigureTag)

