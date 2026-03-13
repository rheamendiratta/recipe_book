import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["ingredientRows", "stepRows"]

  get nextIngredientIndex() {
    return this.ingredientRowsTarget.querySelectorAll("tr").length + 1
  }

  get nextStepIndex() {
    const rows = this.stepRowsTarget.querySelectorAll("tr")
    return rows.length + 1
  }

  addIngredientRow() {
    const i = this.nextIngredientIndex
    const tr = document.createElement("tr")
    tr.innerHTML = `
      <td><input type="text" name="ingredient_qty_${i}" style="width:60px;"></td>
      <td><input type="text" name="ingredient_unit_${i}" style="width:80px;" placeholder="g, cup, tsp…"></td>
      <td><input type="text" name="ingredient_name_${i}" style="width:250px;"></td>
      <td><button type="button" data-action="click->recipe-form#removeRow">Remove</button></td>
    `
    this.ingredientRowsTarget.appendChild(tr)
  }

  addStepRow() {
    const i = this.nextStepIndex
    const tr = document.createElement("tr")
    tr.innerHTML = `
      <td>${i}</td>
      <td><textarea name="step_instruction_${i}" rows="2" style="width:450px;"></textarea></td>
      <td><button type="button" data-action="click->recipe-form#removeRow">Remove</button></td>
    `
    this.stepRowsTarget.appendChild(tr)
  }

  removeRow(event) {
    event.target.closest("tr").remove()
  }
}
