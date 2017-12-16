/**
 * Webpack configuration for production
 */
import UglifyJsWebpackPlugin from 'uglifyjs-webpack-plugin';
import ExtractTextWebpackPlugin from 'extract-text-webpack-plugin';
import CleanWebpackPlugin from 'clean-webpack-plugin';
import Webpack from 'webpack';
import merge from 'webpack-merge';
import common from './webpack.common';
import AppConfig from '../app.confg';

export default merge.smart(common, {
    // let's include source map for easier debugging
    devtool: 'source-map',
    entry: { main: AppConfig.entries.main, },

    output: {
        publicPath: './',
        path: AppConfig.paths.dist,
    },
    module: {
        rules: [{
            test: /\.scss$/,
            // extracts bundled css into separate stylesheet
            use: ExtractTextWebpackPlugin.extract({
                use: [{
                    loader: "css-loader"
                }, {
                    loader: "sass-loader"
                }],
                // use style-loader in development
                fallback: "style-loader"
            })
        }]
    },
    plugins: [
        // clean distribution folder
        new CleanWebpackPlugin(['docs']),
        // file to extract css
        new ExtractTextWebpackPlugin('[name].css'),
        // minimize JavaScript file
        new UglifyJsWebpackPlugin({ sourceMap: true, }),
        // minimize css
        new Webpack.LoaderOptionsPlugin({ debug: false, minimize: true,})
    ],
});
