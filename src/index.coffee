YML     = require "js-yaml"
util    = require "util"
gutil   = require "gulp-util"
through = require "through2"

# ---------------
processFile = ( file, opts ) ->
  content = file.contents.toString "utf8"
  json    = YML.safeLoad content, opts
  file.path = gutil.replaceExtension file.path, ".json"
  file.contents = new Buffer JSON.stringify json
  file


# ---------------
module.exports = ( opts = { } ) ->

  # Construct stream
  through.obj ( file, enc, cb ) ->

    if file.isStream( )
      @emit "error", gutil.PluginError "gulp-yml", "Streams are not supported!"

    else if file.isBuffer( )
      try
        @push processFile file, opts
        do cb

      catch e
        @emit "error", e
        do cb

    else if file.isNull( )
      @push file
      do cb
