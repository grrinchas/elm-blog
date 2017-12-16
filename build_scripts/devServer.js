/**
 * Script for Elm application development which includes hot reloading.
 * Note that bundled webpack files fill be served from the memory.
 */
import express from 'express';
import path from 'path';
import open from 'opn';
import chalk from 'chalk';
import webpack from 'webpack';
import webpackDevMiddleware from 'webpack-dev-middleware';
import webpackHotMiddleware from 'webpack-hot-middleware';
import webpackConfig from '../config/webpack.dev';

const port = 3000;
const app = express();
const bundler = webpack(webpackConfig);

// Serve bundled files from the memory
app.use(webpackDevMiddleware(bundler, {
    publicPath: webpackConfig.output.publicPath,
    noInfo: true, // suppress all webpack log output
    stats: {
        colors: true
    }
}));

// Recompile files on any change
app.use(webpackHotMiddleware(bundler, {
    reload: true,
}));


// This is single page application, therefore we route all the requests to the index.html
app.get('*', (req, res) => {
    res.sendFile(path.join(__dirname, '../src/index.html'));
});


// Start the server
app.listen(port, (err) => {
    if (err) {
        console.log(chalk.red(err));
    } else {
        open(`http://localhost:${port}`);
        console.log(chalk.green(`Starting server on port ${port}`));
    }
});
