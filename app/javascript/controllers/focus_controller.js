import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="focus"
export default class extends Controller {
  static values = {
    first: Number
  }
  connect() {
    if (this.firstValue === 0) {
      // Focus the element
      this.element.focus();
      // Add the highlight class to the div
      this.element.classList.add('focus-action-element')

      // Remove the highlight class after 2 seconds (adjust the time as needed)
      setTimeout(() => {
        this.element.classList.remove('focus-action-element');
      }, 1000);
    }
  }
}
