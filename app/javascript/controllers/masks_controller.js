window.$ = window.jQuery = require('jquery')
require('jquery-mask-plugin')

import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="masks"
export default class extends Controller {
  connect() {
    this.maskFields()
  }

  maskFields() {
    $('[data-masks-target="cpf"]').mask('000.000.000-00')
  }
}
