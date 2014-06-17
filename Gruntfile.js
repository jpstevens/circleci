module.exports = function(grunt) {

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    coffeelint: {
      files: ["src/*.coffee", "src/**/*.coffee", "test/*.coffee", "test/**/*.coffee"],
      options: {
        max_line_length: {
          level: "ignore"
        }
      }
    },
    coffee: {
      glob_to_multiple: {
        expand: true,
        flatten: false,
        cwd: 'src/',
        src: ['*.coffee'],
        dest: 'dist/',
        ext: '.js'
      }
    },
    clean: ["dist"],
    mochaTest: {
      feature: {
        options: {
          reporter: 'list',
          require: 'coffee-script/register',
          colors: true
        },
        src: ['tests/**/*-spec.coffee']
      }
    },
    bump: {
      options: {
        files: ['./package.json'],
        updateConfigs: ['pkg'],
        commitFiles: ['./package.json'],
        pushTo: 'upstream'
      }
    },
    exec: {
      echo: {
        cmd: 'cat package.json'
      },
      publish: {
        cmd: 'npm publish'
      }
    }
  });

  grunt.loadNpmTasks('grunt-coffeelint');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-mocha-test');
  grunt.loadNpmTasks('grunt-bump');
  grunt.loadNpmTasks('grunt-exec');

  // deploy
  grunt.registerTask('deploy', ['test', 'build', 'bump:build', 'exec:echo']);

  // build
  grunt.registerTask('build', ['coffeelint', 'clean', 'coffee']);
  
  // test
  grunt.registerTask('test', ['mochaTest']);
  
  // default
  grunt.registerTask('default', ['test', 'build']);
};
