import {
  Controller
} from "@hotwired/stimulus"
import {
  createConsumer
} from "@rails/actioncable"

export default class extends Controller {
  static values = {
    conversationId: Number
  }
  static targets = ["milts"]

  connect() {
    this.channel = createConsumer().subscriptions.create({
      channel: "ConversationChannel",
      id: this.conversationIdValue
    }, {
      received: data => this.#insertMiltAndScrollDown(data)
    })
    console.log(`Subscribed to the conversation with the id ${this.conversationIdValue}.`)
  }

  disconnect() {
    console.log("Unsubscribed from the conversation")
    this.channel.unsubscribe()
  }

  #insertMiltAndScrollDown(data) {
    this.miltsTarget.insertAdjacentHTML("beforeend", data)
    this.miltsTarget.scrollTo(0, this.miltsTarget.scrollHeight)
  }
}
