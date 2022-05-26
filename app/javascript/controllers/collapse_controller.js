// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["defaultsidebar", "sidebar"]

  connect() {
    console.log('Hello, Stimulus!');
    console.log(this.sidebarTarget);
    console.log(this.defaultsidebarTarget);
  }

  close(event) {
    event.preventDefault()
    this.sidebarTarget.classList.remove("d-md-block")
    this.sidebarTarget.classList.add("d-none")
    this.defaultsidebarTarget.classList.remove("d-none")
  }

  open(event) {
    event.preventDefault()
    this.sidebarTarget.classList.add("d-md-block")
    this.sidebarTarget.classList.remove("d-none")
    this.defaultsidebarTarget.classList.add("d-none")
  }
}
