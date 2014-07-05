module.exports = function(grunt) {

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    coffeelint: {
      files: ['src/**/*.coffee']
    },
    watch: {
      files: ['<%= coffeelint.files %>'],
      tasks: ['mochaTest']
    },
    mochaTest: {
      unit: {
        options: {
          reporter: 'spec',
          require: [
            'coffee-script/register',
            function(){ expect=require('chai').expect; },
            function(){ sinon=require('sinon'); }
          ]
        },
        src: ['tests/unit/**/*-spec.coffee']
      },
      feature: {
        options: {
          timeout: 10000,
          reporter: 'spec',
          require: [
            'coffee-script/register',
            function(){ expect=require('chai').expect; },
            function(){ sinon=require('sinon'); }
          ]
        },
        src: ['tests/feature/**/*-spec.coffee']
      }
    },
    coffee: {
      glob_to_multiple: {
        expand: true,
        flatten: false,
        cwd: 'src/',
        src: ['**/*.coffee'],
        dest: 'dist/',
        ext: '.js'
      }
    },
    clean: ["dist"],
    copy: {
      json: {
        expand: true,
        cwd: 'src/',
        src: ['**/*.json'],
        dest: 'dist/',
        filter: 'isFile'
      }
    }
  });

  require('load-grunt-tasks')(grunt);

  // test
  grunt.registerTask('test:unit', 'mochaTest:unit');
  grunt.registerTask('test:feature', 'mochaTest:feature');
  grunt.registerTask('test', ['test:unit', 'test:feature']);

  // build
  grunt.registerTask('build', ['clean', 'coffeelint', 'coffee', 'copy']);

  grunt.registerTask('default', ['test', 'build']);

};
