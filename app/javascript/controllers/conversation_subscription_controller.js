import {
  Controller
} from "@hotwired/stimulus"
import {
  createConsumer
} from "@rails/actioncable"

export default class extends Controller {
  static values = {
    conversationId: Number,
    userId: Number
  }
  static targets = ["milts", "count"]

  connect() {
    console.log(this);
    this.miltsTarget.scrollTop = this.miltsTarget.scrollHeight
    this.channel = createConsumer().subscriptions.create({
      channel: "ConversationChannel",
      id: this.conversationIdValue
    }, {
      received: data => {
        const parser = new DOMParser();
        const document = parser.parseFromString(data.html, "text/html");
        const milt = document.querySelector("div")
        this.#setClassForCurrentUser(milt, data)
        this.miltsTarget.appendChild(milt)
        this.miltsTarget.scrollTo(0, this.miltsTarget.scrollHeight)
        this.countTarget.innerHTML = data.html2
      }
    })
    console.log(`Subscribed to the conversation with the id ${this.conversationIdValue}.`)
  }

  disconnect() {
    console.log("Unsubscribed from the conversation")
    this.channel.unsubscribe()
  }

  #setClassForCurrentUser(milt, data) {
    if (data.user_id === this.userIdValue) {
      milt.classList.add("milt-current-user")
    } else {
      milt.classList.remove("milt-current-user")
    }
  }
}
