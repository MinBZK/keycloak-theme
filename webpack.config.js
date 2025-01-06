const path = require('path');

const CopyPlugin = require("copy-webpack-plugin");


module.exports = {
  mode: 'development',
  entry: {},
  output: {
    filename: 'template.js',
    path: path.resolve(__dirname, 'theme/nl-design-system/common/resources')
  },
  devtool: 'source-map',
  plugins: [
    new CopyPlugin({
        patterns: [
          { from: "node_modules/@nl-rvo/assets/fonts", to: "assets/fonts" },
          { from: "node_modules/@nl-rvo/assets/icons", to: "assets/icons" },
          { from: "node_modules/@nl-rvo/assets/images", to: "assets/images" },
          { from: "node_modules/@nl-rvo/design-tokens/dist/index.css", to: "design-tokens/index.css" },
          { from: "node_modules/@nl-rvo/design-tokens/dist/index.js", to: "design-tokens/index.js" },
          { from: "node_modules/@nl-rvo/component-library-css/dist/index.css", to: "component-library-css/index.css" },
        ],
    })
  ]
};
