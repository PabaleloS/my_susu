import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider"
export default class extends Controller {
  static targets = ['input', 'contribution']
  connect() {
    console.log('slider controller connected')
  }

  update() {
    this.contributionTarget.innerText = this.inputTarget.value
  }
}
