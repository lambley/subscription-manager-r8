import { Controller } from "@hotwired/stimulus";
import debounce from "lodash.debounce";

export default class extends Controller {
  static targets = ["list"];

  connect() {
    const searchInput = document.getElementById("search");
    if (searchInput) {
      searchInput.addEventListener(
        "keyup",
        debounce(this.search.bind(this), 300)
      );
    }
  }

  search(event) {
    const query = document.getElementById("search").value;
    const form = event.target.closest("form");

    fetch(`${form.action}?search=${encodeURIComponent(query)}`, {
      headers: {
        "X-Requested-With": "XMLHttpRequest",
        Accept: "text/javascript",
      },
    })
      .then((response) => response.text())
      .then((html) => {
        this.listTarget.innerHTML = html;
      })
      .catch((error) => console.error("Error:", error));
  }
}
