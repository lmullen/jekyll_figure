# jekyll_figure

Adds a Liquid `figure` tag to a [Jekyll][] site

Lincoln A. Mullen | lincoln@lincolnmullen.com | http://lincolnmullen.com

## Installation

Add this line to your Jekyll site's `Gemfile`:

    gem 'jekyll_figure'

And then execute:

    bundle

In the Jekyll site's `_config.yml` file, add this line:

    gems: [jekyll_figure]

If you have a directory where you keep your figures, add these lines to
`_config.yml`:

    figures:
      dir: /figures

## Usage

Creates a Liquid figure tag. The figure tag should take this form:

    {% figure filename svg,png,pdf 'Your caption here' %}

The first value is the filename, which should be shared across every
format of the figure. The second value is a comma-separated list of
extensions for the filename. The third value is a quoted caption. The
tag will produce an img tag for the first file format in the list of
extensions. It will include a caption with links to all the figure
formats. If the figures directory is set in `_config.yml`, then the
image and the links will point there.

## License

MIT License <http://lmullen.mit-license.org/>

  [Jekyll]: http://jekyllrb.com/

