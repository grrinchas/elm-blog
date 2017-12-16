/**
 * Common webpack configuration used by development and production.
 */
import HtmlWebpackPlugin from 'html-webpack-plugin';

export default {
    target: 'web',
    output: { filename: '[name].js', },
    module: {
        noParse: /\.elm$/, // we don't need to parse elm files
        rules: [
            {
                test: /\.scss$/,
                use: [{ loader: "style-loader" }, { loader: "css-loader" }, { loader: "sass-loader" }]
            },
            {
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/],
                use: { loader: 'elm-webpack-loader?verbose=true&warn=true&forceWatch=true', },
            },
            {
                test: /\.(svg|woff|woff2|eot|ttf|otf)$/,
                loader: 'url-loader',
                options: { name: 'fonts/[name].[ext]', limit: 50, },
            },
            {
                test: /\.(png|jpg|gif)$/,
                loader: 'file-loader',
                options: {
                    name: 'images/[name].[ext]',
                },
            },
        ],
    },
    plugins: [
        // plugin for automatically injecting bundled js file into html
        new HtmlWebpackPlugin({ template: 'src/index.html', inject: true, }),
    ],
};
