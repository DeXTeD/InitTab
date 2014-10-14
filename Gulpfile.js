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
    'bower_components/underscore/underscore.js',
    'bower_components/angular/angular.js',
    'bower_components/angular-resource/angular-resource.js',
    'bower_components/angular-route/angular-route.js',
    // 'bower_components/angular-animate/angular-animate.js',
    'bower_components/angular-sortable-view/src/angular-sortable-view.js',
    'src/main.coffee',
  ],
  styles: ['less/**/*.less'],
  mainStyle: ['less/main.less'],
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
  // gulp.watch(paths.styles, ['styles']);
});


gulp.task('styles', function() {
  // gulp.src(paths.mainStyle)
  //   .pipe(less())
  //   .pipe(autoprefixer())
  //   .pipe(gulp.dest(output));
});


gulp.task('build', ['scripts', 'styles']);
gulp.task('default', ['scripts', 'styles', 'watch']);