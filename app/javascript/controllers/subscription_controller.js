import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "monthlyBudgetDisplay",
    "monthlyBudgetInput",
    "monthlyBudgetCurrencySymbol",
    "annualBudgetDisplay",
    "annualBudgetInput",
    "annualBudgetCurrencySymbol",
    "editMonthlyButton",
    "saveMonthlyButton",
    "cancelMonthlyButton",
    "editAnnualButton",
    "saveAnnualButton",
    "cancelAnnualButton",
    "summaryText",
    "monthlyActualValue",
  ];

  connect() {
    console.log("Connected to subscription controller");
    this.assessBudget();
  }

  toggleMonthlyBudgetEdit() {
    // toggle the monthly budget display and input
    this.monthlyBudgetDisplayTarget.classList.toggle("hidden");
    this.monthlyBudgetInputTarget.classList.toggle("hidden");
    this.monthlyBudgetCurrencySymbolTarget.classList.toggle("hidden");

    // disable the other edit button while editing
    this.toggleDisable(this.editAnnualButtonTarget);

    // toggle the monthly budget edit and save/cancel buttons
    this.editMonthlyButtonTarget.classList.toggle("hidden");
    this.saveMonthlyButtonTarget.classList.toggle("hidden");
    this.cancelMonthlyButtonTarget.classList.toggle("hidden");
  }

  toggleAnnualBudgetEdit() {
    // toggle the annual budget display and input
    this.annualBudgetDisplayTarget.classList.toggle("hidden");
    this.annualBudgetInputTarget.classList.toggle("hidden");
    this.annualBudgetCurrencySymbolTarget.classList.toggle("hidden");

    // disable the other edit button while editing
    this.toggleDisable(this.editMonthlyButtonTarget);

    // toggle the annual budget edit and save/cancel buttons
    this.editAnnualButtonTarget.classList.toggle("hidden");
    this.saveAnnualButtonTarget.classList.toggle("hidden");
    this.cancelAnnualButtonTarget.classList.toggle("hidden");
  }

  toggleDisable(target) {
    target.disabled = !target.disabled;
    target.classList.toggle("opacity-50");
    target.classList.toggle("cursor-not-allowed");
  }

  handleKeydown(event) {
    if (event.key === "Enter") {
      if (event.target === this.monthlyBudgetInputTarget) {
        this.saveMonthlyBudget();
      } else if (event.target === this.annualBudgetInputTarget) {
        this.saveAnnualBudget();
      }
    }
  }

  assessBudget() {
    // only need to compare monthly, as annual is derived from monthly
    const monthlyBudgetValue = parseFloat(
      this.monthlyBudgetDisplayTarget.textContent
    );
    const monthlyActualValue = parseFloat(
      this.monthlyActualValueTarget.textContent
    );

    console.log("Monthly budget:", monthlyBudgetValue);
    console.log("Monthly actual:", monthlyActualValue);

    if (isNaN(monthlyBudgetValue) || isNaN(monthlyActualValue)) {
      this.summaryTextTarget.textContent = "Please enter a valid budget";
    } else if (monthlyActualValue > monthlyBudgetValue) {
      this.summaryTextTarget.textContent = "You are over budget!";
      this.summaryTextTarget.classList.add("bg-red-600");
    } else if (monthlyActualValue < monthlyBudgetValue) {
      this.summaryTextTarget.textContent = "You are under budget!";
      this.summaryTextTarget.classList.add("bg-green-600");
    } else if (monthlyActualValue === monthlyBudgetValue) {
      this.summaryTextTarget.textContent = "You are on budget!";
      this.summaryTextTarget.classList.add("bg-green-600");
    } else {
      this.summaryTextTarget.textContent = "There was an issue reading the budget";
    }
  }

  saveMonthlyBudget() {
    const monthlyBudget = this.monthlyBudgetInputTarget.value;
    this.saveBudget("monthly", monthlyBudget);
  }

  saveAnnualBudget() {
    const annualBudget = this.annualBudgetInputTarget.value;
    this.saveBudget("annual", annualBudget);
  }

  saveBudget(type, value) {
    let budget;
    if (type === "monthly") {
      budget = value * 12;
    } else if (type === "annual") {
      budget = value;
    }

    fetch("/update_budget", {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document
          .querySelector('meta[name="csrf-token"]')
          .getAttribute("content"),
        Accept: "text/html",
      },
      body: JSON.stringify({ budget }),
    })
      .then((response) => {
        if (response.ok) {
          this.budgetDisplayTarget.textContent = budget;
          if (type === "monthly") {
            this.toggleMonthlyBudgetEdit();
          } else if (type === "annual") {
            this.toggleAnnualBudgetEdit();
          } else {
            console.error("Invalid budget type");
          }
        } else {
          console.error("Error:", response);
        }
      })
      .finally(() => {
        window.location.reload();
        this.assessBudget();
      });
  }
}
