NOTE you need Ruby and RubyGems to compile nanoc files.  View nanoc documentation at:  http://nanoc.stoneship.org

To get this to work:

    gem install bundler
    bundle

Compile the output files:

    nanoc compile

View the page on `localhost:3000`

    nanoc view

View the page on `localhost:3000` and automatically regenerate changed files:

    nanoc autocompile
