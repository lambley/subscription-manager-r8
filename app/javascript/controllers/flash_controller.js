import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.element.addEventListener("click", () => this.close());
    setTimeout(() => this.close(), 3000);
  }

  close() {
    this.element.remove();
  }
}
