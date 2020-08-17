// app/javascript/packs/application.js

import 'core-js/stable'
import 'regenerator-runtime/runtime'
import "bootstrap";
import "../stylesheets/application";
import "./custom";
import "@fortawesome/fontawesome-free/js/all";

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()

require.context('../images', true);

