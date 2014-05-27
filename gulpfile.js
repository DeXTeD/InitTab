var fs = require('fs');

var gulp = require('gulp');
var gutil = require('gulp-util');

var coffee = require('gulp-coffee');
var uglify = require('gulp-uglify');
var less = require('gulp-less');
var minifyCSS = require('gulp-minify-css');
var autoprefixer = require('gulp-autoprefixer');
var concat = require('gulp-concat');
var gulpif = require('gulp-if');

var pkg = require('./package.json');

var paths = {
  script: [
    'bower_components/string_score/string_score.js',
    'bower_components/jquery/dist/jquery.js',
    // 'bower_components/jqueryui/ui/jquery.ui.core.js',
    // 'bower_components/jqueryui/ui/jquery.ui.widget.js',
    // 'bower_components/jqueryui/ui/jquery.ui.mouse.js',
    // 'bower_components/jqueryui/ui/jquery.ui.draggable.js',
    'bower_components/underscore/underscore.js',
    'bower_components/backbone/backbone.js',
    'bower_components/backbone.marionette/lib/backbone.marionette.js',
    // 'bower_components/grid-list/src/gridList.js',
    // 'bower_components/grid-list/src/jquery.gridList.js',
    'bower_components/gridster/dist/jquery.gridster.js',
    'src/models/*.coffee',
    'src/collections/*.coffee',
    'src/views/*.coffee',
    'src/main.coffee',
  ],
  styles: ['less/**/*.less'],
};

var output = 'build';

gulp.task('scripts', function() {
  gulp.src(paths.script)
    .pipe(gulpif(/[.]coffee$/, coffee({bare: true}).on('error', gutil.log)))
    .pipe(concat('all.js'))
    .pipe(gulp.dest(output));
});

/*gulp.task('uglify', function() {
  gulp.src(output+'/'+pkg.name+'.js')
    .pipe(uglify({
      preserveComments: 'some',
      outSourceMap: false
    }))
    .pipe(rename({extname: ".min.js"}))
    .pipe(gulp.dest(output));
});*/


gulp.task('watch', function() {
  gulp.watch(paths.script, ['scripts']);
  gulp.watch(paths.styles, ['styles']);
});


gulp.task('styles', function() {
  gulp.src(paths.styles)
    .pipe(less())
    .pipe(autoprefixer())
    .pipe(gulp.dest(output));
});


gulp.task('build', ['scripts', 'styles']);
gulp.task('default', ['scripts', 'styles', 'watch']);