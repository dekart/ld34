task default: %w[build:web]

namespace :build do
  desc "Build HTML5 client"
  task :web do
    puts "Building HTML5 version..."
    puts

    system("cocos compile -p web -m release --source-map --compile-script 1")

    puts
    puts "Done!"
  end
end