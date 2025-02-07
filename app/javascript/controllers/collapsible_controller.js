import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["item", "collapsedElement"];
  static classes = ["hidden"];

  connect() {
    this.class = this.hasHiddenClass ? this.hiddenClass : "hidden";
  }

  toggle() {
    this.itemTargets.forEach((item) => {
      item.classList.toggle(this.class);
    });

    this.collapsedElementTargets.forEach((collapsedElement) => {
      collapsedElement.classList.toggle(this.class);
    })
  }
}
