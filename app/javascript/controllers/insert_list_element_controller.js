import { csrfToken } from "@rails/ujs"
import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  static targets = ["element", "form"]

  connect() {
    console.log(this.element)
    console.log(this.elementsTarget)
    console.log(this.formTarget)
  }

  send(event) {
    event.preventDefault()

    fetch(this.formTarget.action, {
      method: "POST",
      headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
      body: new FormData(this.formTarget)
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
      })
  }
}
