var YML, gutil, processFile, through, util;

YML = require("js-yaml");

util = require("util");

gutil = require("gulp-util");

through = require("through2");

processFile = function(file, opts) {
  var content, json;
  content = file.contents.toString("utf8");
  json = YML.load(content, opts);
  file.path = gutil.replaceExtension(file.path, ".json");
  file.contents = new Buffer(JSON.stringify(json));
  return file;
};

module.exports = function(opts) {
  if (opts == null) {
    opts = {};
  }
  if (opts.schema) {
    opts.schema = YML[opts.schema];
  }
  return through.obj(function(file, enc, cb) {
    var e;
    if (file.isStream()) {
      return this.emit("error", gutil.PluginError("gulp-yml", "Streams are not supported!"));
    } else if (file.isBuffer()) {
      try {
        this.push(processFile(file, opts));
        return cb();
      } catch (_error) {
        e = _error;
        this.emit("error", e);
        return cb();
      }
    } else if (file.isNull()) {
      this.push(file);
      return cb();
    }
  });
};
