import "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

require('popper.js')
require('bootstrap')
require('data-confirm-modal')

// Rails UJS with Turbo compatibility
import Rails from "@rails/ujs"
Rails.start()
