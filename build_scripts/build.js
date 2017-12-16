/**
 * Script for building application for production.
 */

import webpack from 'webpack';
import chalk from 'chalk';
import webpackConfig from '../config/webpack.prod';

// Webpack bundler with production configuration
const bundler = webpack(webpackConfig);

process.env.NODE_ENV = 'production';

console.log(chalk.blue('Generating minimized bundle for production. This may take a while...'));

bundler.run((err, stats) => {
  if (err) {
    console.log(chalk.red(err));
    return 1;
  }
  console.log(chalk.green("Build was successful."));
  return 0;
});
