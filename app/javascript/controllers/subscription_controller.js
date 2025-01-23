import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["budgetDisplay", "budgetInput", "editButton", "saveButton"];

  toggleBudgetEdit() {
    this.budgetDisplayTarget.classList.toggle("hidden");
    this.budgetInputTarget.classList.toggle("hidden");
    this.editButtonTarget.classList.toggle("hidden");
    this.saveButtonTarget.classList.toggle("hidden");
  }

  saveBudget() {
    const budget = this.budgetInputTarget.value;

    fetch("/update_budget", {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document
          .querySelector('meta[name="csrf-token"]')
          .getAttribute("content"),
        Accept: "text/html", // Expect an HTML response
      },
      body: JSON.stringify({ budget }),
    })
      .then((response) => {
        if (response.ok) {
          this.budgetDisplayTarget.textContent = budget;
          this.toggleBudgetEdit();
        } else {
          console.error("Error:", response);
        }
      })
      .finally(() => {
        window.location.reload();
      });
  }
}
