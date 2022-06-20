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
  static targets = ["items"]

  connect() {
    console.log(`TEST home conversations`)
    // console.log(this.itemsTarget);

    this.channel = createConsumer().subscriptions.create({
      channel: "ConversationChannel",
      id: this.conversationIdValue
    }, {
      received: data => {
        if (data.user_id != this.userIdValue) {
          this.itemsTarget.innerHTML = data.receiver_conversations
        }
       }
     })
     console.log(`Subscribed to the conversation with the id ${this.conversationIdValue}.`)
  }
}
