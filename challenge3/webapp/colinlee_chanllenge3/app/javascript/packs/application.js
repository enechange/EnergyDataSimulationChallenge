// Rails assets
import WebpackerReact from 'webpacker-react';
import 'babel-polyfill';

// Alphabet order
import Hello from './hello';

WebpackerReact.setup({
  Hello,
});

window.WebpackerReact = WebpackerReact;
