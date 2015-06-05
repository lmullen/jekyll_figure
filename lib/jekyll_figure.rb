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

    include Jekyll::Filters

    require "shellwords"

    def initialize(tag_name, text, tokens)
      super
      @text     = text.shellsplit
      @@fig_num = 0
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
      file_slug  = slugify(filename)
      caption    = @text[2]
      img_src    = "#{dir}/#{filename}.#{extensions.first}"

      enumerate  = nil
      analytics  = nil

      flags      = @text.drop(3)
      if flags.length > 0
        flags.each do |flag|
          prop = flag.split('=')
          if prop[0].downcase == 'enumerate'
            enumerate = (prop[1].downcase == 'true')
          elsif prop[0].downcase == 'analytics'
            analytics = (prop[1].downcase == 'true')
          end
        end
      end

      # Should we explicitly enumerate the figures?
      if enumerate.nil?
        if defined? context.registers[:site].config["figures"]["enumerate"] and context.registers[:site].config["figures"]["enumerate"]
          enumerate = true
        end
      end

      enumeration = ""
      if enumerate
        @@fig_num += 1
        enumeration = "Figure #{@@fig_num}: "
        figure_id   = "figure-#{@@fig_num}"
      else
        figure_id   = "figure-#{file_slug}"
      end

      # Should we include analytics links? 
      if analytics.nil?
        if defined? context.registers[:site].config["figures"]["analytics"] and context.registers[:site].config["figures"]["analytics"]
          analytics = true
        end
      end

      ga = ""
      if analytics
        ga = %Q[onclick="ga('send', 'event', { 'eventCategory': 'Figure', 'eventAction': 'View', 'eventLabel': '#{filename}'});"]
      end

      downloads  = proc {
        d = []
        extensions.each do |ext|
          d.push %Q{<a #{ga} href="#{dir}/#{filename}.#{ext}">#{ext.upcase}</a>,}
        end
        d.join(" ")[0..-2]
      }


      "<figure id='#{figure_id}'>"                  +
      "<a #{ga} href='#{img_src}'>"                 +
      "<img src='#{img_src}' alt='#{caption}'></a>" +
      "<figcaption>#{enumeration}"                  +
      "#{caption} [#{downloads.call}]"              +
      "</figcaption>"                               +
      "</figure>"

    end

  end
end

Liquid::Template.register_tag('figure', Jekyll::FigureTag)