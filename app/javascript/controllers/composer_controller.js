import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets =  ["count"];

  connect() {
    this.updateCount();
  }

  updateCount() {
    const count = this.countTarget;
    const textarea = this.element.querySelector("textarea");
    const maxLength = textarea.getAttribute("maxlength");
    const currentLength = textarea.value.length;
    count.textContent = `${currentLength}/${maxLength} characters`;
  }
}
