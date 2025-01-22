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
    // Make an AJAX request to update the budget

    try {
      fetch("/update_budget", {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document
            .querySelector('meta[name="csrf-token"]')
            .getAttribute("content"),
        },
        body: JSON.stringify({ budget }),
      })
        .then((response) => response.json())
        .then((data) => {
          this.budgetDisplayTarget.innerHTML = data.budget;
          this.toggleBudgetEdit();
        });
    } catch (error) {
      console.error("Error:", error);
    }
  }
}
