import {
  Controller
} from "@hotwired/stimulus"
import {
  createConsumer
} from "@rails/actioncable"

export default class extends Controller {
  static values = {
    conversationsId: Array,
    userId: Number
  }
  static targets = ["items"]

  connect() {
    // console.log(this.conversationsIdValue);
    this.conversationsIdValue.forEach((conversationId) => {
      this.channel = createConsumer().subscriptions.create({
        channel: "ConversationChannel",
        id: conversationId
      }, {
        received: data => {
          if (data.correspondant_id == this.userIdValue) {
            this.itemsTarget.innerHTML = data.receiver_conversations
          }
         }
       })
       console.log(`Subscribed to the conversation with the id ${conversationId}.`)
    })
  }
}
