// import {
//   Controller
// } from "stimulus"
import {
  Controller
} from "@hotwired/stimulus"
import {
  createConsumer
} from "@rails/actioncable"

export default class extends Controller {
  static targets = ["sentMilts", "receivedMilts", "exchangedMilts"]
  static values = {
    conversationsId: Array,
    userId: Number
  }

  async connect() {
    // console.log(this.conversationsIdValue);
    // console.log(this.userIdValue);
    // console.log(this.exchangedMiltsTarget);
    this.conversationsIdValue.forEach((conversationId) => {
      this.channel = createConsumer().subscriptions.create({
        channel: "ConversationChannel",
        id: conversationId
      }, {
        received: data => {
          if (data.correspondant_id == this.userIdValue) {
            this.exchangedMiltsTarget.innerHTML = data.exchange_milts
          }
        }
      })
      console.log(`Subscribed to the conversation with the id ${conversationId}.`)
    })
  }

  async addReceivedMilts() {
    await fetch('/add_received_milts', {
      method: 'GET',
      mode: 'cors',
      cache: 'no-cache',
      credentials: 'same-origin',
      headers: {
        'Accept': 'application/json'
      }
    })
      .then(response => response.json())
      .then((data) => {
        if (data.update_milts_count) {
          this.exchangedMiltsTarget.innerHTML = data.update_milts_count
        }
      })
  }

  async addSentMilts() {
    await fetch('/add_sent_milts', {
        method: 'GET',
        mode: 'cors',
        cache: 'no-cache',
        credentials: 'same-origin',
        headers: {
          'Accept': 'application/json'
        }
      })
      .then(response => response.json())
      .then((data) => {
        if (data.update_milts_count) {
          this.exchangedMiltsTarget.innerHTML = data.update_milts_count
        }
      })
  }
}
