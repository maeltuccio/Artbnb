import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  connect() {
    console.log("Flatpickr Stimulus Controller connected:", this.element);
    flatpickr(this.element, {
      enableTime: false,
      dateFormat: "Y-m-d",
    });
  }
}
