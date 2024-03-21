import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider"
export default class extends Controller {
  static targets = ['input', 'contribution']
  connect() {
    console.log(this.element)
  }

  update() {
    this.contributionTarget.innerText = this.inputTarget.value
  }
}
