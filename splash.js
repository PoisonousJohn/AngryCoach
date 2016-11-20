import fn from '../';
const mobisplash = require('mobisplash');

mobisplash('logo.svg', {platform: 'android', draw9patch: false}).then(() => {
    console.log("generated");
});


