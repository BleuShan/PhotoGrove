import './polyfills'
import './src/Stylesheets'
import Elm from './src/Main'
import {name, version} from './package.json'

const flags = {
  name,
  version,
  urlPrefix: null
}

Elm.Main.embed(document.querySelector('main'), flags)
