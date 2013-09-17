###
# Grunt Config
This serves as the main configuration file for grunt.
It controls the different tasks.
Unfortunately, it also doesn"t get along well with dox our documentation
engine, because dox doesn"t handle comment like syntax in strings
very well, and chokes on it.
###
banner = '\n/*\n<%= pkg.name %> - v<%= pkg.version %> - ' +
        '<%= grunt.template.today("yyyy-mm-dd") %> \n' +
        'Created with Care by Ben McCormick\n'+
        'Feel free to check out the source or' +
        ' contribute at \nhttps://github.com/ben336/summitbingo\n*/\n'



module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    less: 
      compile: 
        options: 
          banner:banner
          paths: ["static/src/less/**/*.less"]
        files: 
          "static/app/css/signup.css": "static/src/less/signup.less" # 1:1 compile
    uglify: 
      options: 
        mangle:false
        banner: banner
      my_target:
        files:
          'js/bingo.js': ['js/bingo.src.js']
    coffee:
      compile:
        files:
          'static/app/js/signup.js': 'static/src/coffee/signup.coffee', # 1:1 compile
    watch: 
      scripts:
        files: ["static/src/less/**/*.less","static/src/coffee/**/*.coffee"],
        tasks: ["less","coffee"],
        options: 
          nospawn: true

  grunt.loadNpmTasks "grunt-contrib-less"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.registerTask "default", ["less","coffee"]