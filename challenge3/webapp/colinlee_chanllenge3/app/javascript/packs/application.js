// Rails assets
import WebpackerReact from 'webpacker-react';
import 'babel-polyfill';

// Alphabet order
import Report from './report';

WebpackerReact.setup({
  Report,
});

window.WebpackerReact = WebpackerReact;
