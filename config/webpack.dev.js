/**
 * Webpack configuration for development.
 */
import Webpack from 'webpack';
import merge from 'webpack-merge';
import common from './webpack.common';
import AppConfig from '../app.confg';

export default merge.smart(common, {
    devtool: 'inline-source-map',
    entry: {
        main:
            [
                // This entry is used by hot reloading
                'webpack-hot-middleware/client',
                // This is the main entry
                AppConfig.entries.main
            ],
    },
    output: {
        publicPath: '/',
        // Output files in the build directory in the memory
        path: AppConfig.paths.build,
    },
    plugins: [
        // Both plugins are needed for hot reloading
        new Webpack.HotModuleReplacementPlugin(),
        new Webpack.NoEmitOnErrorsPlugin(),
    ],
});
