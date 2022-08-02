import {
  Controller
} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["btn"]
  static values = {
    conversationId: Number,
    counter: Number
  }

  connect() {
    console.log("hello from load controller");

  }

  load() {
    console.log("this.conversationIdValue", this.conversationIdValue);
    console.log("this.counterValue", this.counterValue);
    fetch(`/conversations/${this.conversationIdValue}?load_more=${this.counterValue + 1}`)
      .then((data) => {
        console.log(data);
        if (data.counting) {
          nextMiltsTarget.innerHTML = data.counting
        }
      })
  }
}
