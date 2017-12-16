
# Elm development environment

Development environment for writing Elm apps.

Based on the amazing work of [javascript-development-environment](https://github.com/coryhouse/javascript-development-environment).


## Features

1. Development Server with hot reloading.
2. Optimised bundling and minification for the production.


## Install

First let's install dependencies

* If you don't have install [node.js](https://nodejs.org/en/).
* Also you will need [yarn](https://yarnpkg.com/en/) package manager.
* And of course [elm](http://elm-lang.org/) environment.

After that

* Clone this repo in a new project:
```bash
git clone https://github.com/grrinchas/dg-elm-starter-kit my-elm-project
```

* Re-initialise as your own repo:
```bash
cd my-elm-project
rm -rf .git         # on Windows: rmdir .git /s /q
git init
```

* Install all `JavaScript` dependencies:
```bash
yarn install
```

* Install all `Elm` dependencies:
```bash
elm-package install
```

Development

* Start development server:
```bash
yarn run start
```
* Then navigate to:
```bash
http://localhost:3000
```

Production

* To bundle files for deployment:
```bash
yarn run build
```

## Folder Structure

Here are folders and files for development environment.

```bash
-- build_scripts/           # Contains scripts related with server
   -- build.js                # Build files for production
   -- devServer.js            # Start development server
   -- prodServer.js           # Start production server
-- config/                  # Contains scripts for Webpack configuration
   -- webpack.common.js       # Common configuration for production and development
   -- webpack.dev.js          # Development configuration
   -- webpack.prod.js         # Production configuration
+- docs/                    # Output folder for production
+- elm-stuff/               # Elm dependencies
+- node_modules/            # JavaScript dependencies
-- src/                     # Folder for source files
   -- app/                    # Elm application
   |  -- Main.elm               # Entry point of the application
   -- index.html              # Index file where SPA file be inserted
   -- main.js                 # Entry point for the application
   -- main.scss               # Entry point for the stylesheets
-- .babelrc                 # Babel configuration file
-- .editorconfig            # Configuration for the editors
-- app.config.js            # Mostly contains some paths used by Webpack
-- elm-package.json
-- LICENSE
-- package.json
-- README.md
-- yarn.lock
```

## Dependencies in `package.json`

Here are all the dependencies for development and building. I strongly encourage to read official documentation for each of them.

| **Dependency**                                                                             | **Use**                                                                         |
| -------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------|
| [babel-cli](https://babeljs.io/docs/usage/cli/)                                            | Babel Command line interface                                                    |
| [babel-preset-env](https://www.npmjs.com/package/babel-preset-env)                         | Babel preset for running all the latest standardized JavaScript features        |
| [chalk](https://www.npmjs.com/package/chalk)                                               | For Colorful log messages                                                       |
| [clean-webpack-plugin](https://www.npmjs.com/package/clean-webpack-plugin)                 | Cleans folders before building                                                  |
| [css-loader](https://www.npmjs.com/package/css-loader)                                     | Add CSS support to Webpack                                                      |
| [elm-format](https://github.com/avh4/elm-format)                                           | Formats elm code                                                                |
| [elm-webpack-loader](https://www.npmjs.com/package/elm-webpack-loader)                     | Add Elm support to Webpack                                                      |
| [express](https://expressjs.com/)                                                          | Server for development and production builds                                    |
| [extract-text-webpack-plugin](https://www.npmjs.com/package/extract-text-webpack-plugin)   | Extracts CSS into separate file for production build                            |
| [file-loader](https://www.npmjs.com/package/file-loader)                                   | Adds file loading support to Webpack                                            |
| [html-webpack-plugin](https://www.npmjs.com/package/html-webpack-plugin)                   | Inserts bundled files into `index.html`                                         |
| [materialize-css](http://materializecss.com/)                                              | CSS framework based on Google Material Design.                                  |
| [node-sass](https://www.npmjs.com/package/node-sass)                                       | For compiling SASS files                                                        |
| [npm-run-all](https://www.npmjs.com/package/npm-run-all)                                   | Display results of multiple commands on single command line                     |
| [opn](https://www.npmjs.com/package/opn)                                                   | Open app in default browser                                                     |
| [sass-loader](https://www.npmjs.com/package/sass-loader)                                   | Add SASS support for Webpack                                                    |
| [style-loader](https://www.npmjs.com/package/style-loader)                                 | Add Style support to Webpack                                                    |
| [uglifyjs-webpack-plugin](https://www.npmjs.com/package/uglifyjs-webpack-plugin)           | Plugin for minimising JavaScript files                                          |
| [url-loader](https://www.npmjs.com/package/url-loader)                                     | Add url loading support to Webpack                                              |
| [webpack](https://webpack.js.org/)                                                         | Bundler with plugin system and integrated development server                    |
| [webpack-dev-middleware](https://www.npmjs.com/package/webpack-dev-middleware)             | Add middleware support to webpack                                               |
| [webpack-hot-middleware](https://www.npmjs.com/package/webpack-hot-middleware)             | Add hot reloading to webpack                                                    |
| [webpack-merge](https://www.npmjs.com/package/webpack-merge)                               | Merge multiple Webpack configurations in one file                               |


## Dependencies in `elm-package.json`

Here are all the dependencies for Example application.

| **Dependency**                                                                                             | **Use**                                |
| ---------------------------------------------------------------------------------------------------------- | -------------------------------------- |
| [elm-lang/core](http://package.elm-lang.org/packages/elm-lang/core/latest)                                 | Core features for the Elm language     |
| [elm-lang/html](http://package.elm-lang.org/packages/elm-lang/html/latest/)                                | Add html support                       |


