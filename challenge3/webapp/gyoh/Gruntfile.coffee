module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"

    coffee:
      compile:
        options:
          bare: true
        files:
          "public/js/app.js": "src/app.coffee"
          "public/js/controllers.js": "src/controllers/*.coffee"
          "public/js/services.js": "src/services/*.coffee"

    clean:
      js: ["public/js/**.js"]

  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-clean"

  grunt.registerTask "default", ["coffee"]