import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-users"
export default class extends Controller {
  static targets = [ "form", "input", "users_list" ];

  connect() {
  }

  update() {
    const url = `${this.formTarget.action}?query=${this.inputTarget.value}`;
    fetch(url,{
      headers: { "Accept": "text/plain" }
    })
      .then(response => response.text())
      .then(data => {
        console.log({data})
        this.users_listTarget.outerHTML = data;
      })
  }
}
