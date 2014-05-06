gulp-yml
========

[![Build Status](https://travis-ci.org/lazutkin/gulp-yml.svg)](https://travis-ci.org/lazutkin/gulp-yml)

# Detailed documentation will be writen soon...

# Installation

Install plugin

```
npm install gulp-yml --save-dev
```

Add yml-compilation task into your gulp-file:

```coffeescript
paths =
  build: "build"
  scripts: yml: "src/**/*.yml"

gulp.task "yml:compile", ->
  gulp
    .src( paths.scripts.yml )
    .pipe( yml( ).on( "error", gutil.log ) )
    .pipe( concat "all.yml" )
    .pipe( gulp.dest( paths.build ) )
```

Finish

## Options

Plugin redirects passed options directly to [js-yaml#safeLoad( )](https://github.com/nodeca/js-yaml#safeload-string---options-), so read its documentation for details.
