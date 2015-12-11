require 'active_support/all'
require 'guard/compat/plugin'

# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec features) \
#  .select{|d| Dir.exists?(d) ? d : UI.warning("Directory #{d} does not exist")}

## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), then you will want to move
## the Guardfile to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"



module JavascriptProject
  class << self
    def read_config
      path = File.expand_path('../project.json', __FILE__)

      config = File.read(path) if File.file?(path)

      if config.blank?
        generate_config
      else
        @config = JSON.parse(config)
      end
    end

    def generate_config
      ::Guard::UI.info "Re-generating project config"

      template = JSON.parse(
        File.read(
          File.expand_path('../project.template.json', __FILE__)
        )
      )

      template['jsList'] = Dir['src/**/*.js']

      File.open(File.expand_path('../project.json', __FILE__), 'w+') do |f|
        f.write(JSON.dump(template))
      end

      @config = template
    end

    def config
      @config || read_config
    end
  end
end


module LocaleBuilder
  class << self
    OUTPUT_FOLDER = "src/locales"

    def rebuild_all
      cleanup_output_folder

      Dir["locales/*"].each do |folder|
        rebuild_language(File.basename(folder))
      end
    end

    def cleanup_output_folder
      ::Guard::UI.info 'Cleaning up compiled locales'

      ::FileUtils.rm_r(
        Dir[File.expand_path("../#{ OUTPUT_FOLDER }/*", __FILE__)]
      )
    end

    def rebuild_language(language)
      ::Guard::UI.info "Re-building locale files for #{ language.upcase }"

      locale = {}

      error_happened = false

      Dir["locales/" + language + "**/*.yml"].each do |file|
        begin
          content = YAML.load_file(file)

          locale.deep_merge!(content) unless content.blank?
        rescue Exception => e
          ::Guard::UI.error "Failed to load YML file: #{ e.message }"
          ::Guard::Notifier.notify(file, image: :failed, title: "Failed to rebuild locale")

          error_happened = true
        end
      end

      dump_language_file(language, locale)

      if error_happened
        @error_happened = true
      elsif @error_happened
        @error_happened = false

        ::Guard::Notifier.notify("All is clear!", image: :success, title: "Locale rebuild successful")
      end
    end

    def dump_language_file(language, content)
      FileUtils.mkdir_p(OUTPUT_FOLDER)

      File.open(OUTPUT_FOLDER + "/" + language + ".js", "w+") do |file|
        file << %{var I18n = I18n || {};I18n.locale = "%s";I18n.translations = %s;} % [
          language,
          JSON.dump(content)
        ]
      end
    end
  end
end


# the double-colons below are *required* for inline Guards!!!
module ::Guard
  class SourceCode < Plugin

    def initialize(options = {})
      opts = options.dup

      #@my_option = opts.delete(:my_special_option)

      super(opts) # important to call + avoid passing options Guard doesn't understand
    end

    def start
      rebuild_all_source_codes
    end

    def reload
      rebuild_all_source_codes
    end

    def rebuild_all_source_codes
      puts "Rebuilding all source codes"

      LocaleBuilder.rebuild_all
      JavascriptProject.generate_config
      JavascriptProject.read_config
    end
  end
end



coffeescript_options = {
  input: 'coffeescript',
  output: 'src/game',
  patterns: [%r{^coffeescript/(.+\.(?:coffee|coffee\.md|litcoffee))$}],
  bare: true,
  hide_success: true,
  all_on_start: true
}

guard 'coffeescript', coffeescript_options do
  callback :start_begin do
    ::Guard::UI.info 'Deleting compiled source codes'

    ::FileUtils.rm_r(
      Dir[File.expand_path("../#{ coffeescript_options[:output] }/*", __FILE__)]
    )
  end

  coffeescript_options[:patterns].each do |pattern|
    watch(pattern)
  end
end

# Важно: guard для исходного кода должен объявляться ПОСЛЕ guard-а для coffeescript,
#        в противном случае конфиг проекта будет формироваться ДО того, как скомпилируются
#        все файлы исходного кода, и новые файлы могут не попасть в проект, а значит не загрузиться.
guard :source_code do
  watch(%r{^src/.+$}) do |paths|
    unless paths & JavascriptProject.config['jsList'] == paths
      ::Guard::UI.info 'Found new source files which are not in config yet'

      JavascriptProject.generate_config
    end
  end

  watch(%r{^project.json}) do
    ::Guard::UI.info "Project config changed, re-reading"

    JavascriptProject.read_config
  end


  watch(%r{^project.template.json}) do
    ::Guard::UI.info "Project config template changed"

    JavascriptProject.generate_config
  end

  watch(%r{^locales/.+}) do |paths|
    languages = paths.map{|path| path.split('/')[1] }.uniq

    languages.each do |language|
      LocaleBuilder.rebuild_language(language)
    end
  end
end
