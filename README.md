Ludum Dare Game

This game skeleton allows you to easily start developing a game with Cocos2d-x engine using CoffeeScript. Coffee files automatically compile to JavaScript on the fly.

# Getting Started

To launch the game you should install Cocos2d-x, Ruby interpreter, and Bundler gem.

Open two terminal windows and launch the following commands (one per window):

    cocos run -p web

    bundle exec guard

The first one launches Cocos development server and opens the project in a new browser tab. The second one start Guard process which monitors source code folder and compiles source code files as soon as they change. It also re-creates project configuration file from a template and compiles localization files from YAML to JSON.

# Building Project

To build your game run the following command:

    bundle exec rake build:web

The game will compile to the 'publish' folder.

# Credits

Alexey Dmitriev