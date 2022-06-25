import {
  Controller
} from "stimulus"

export default class extends Controller {
  static targets = ["sentMilts", "receivedMilts", "exchangedMilts"]

  connect() {
  }

  addReceivedMilts() {
    fetch('/add_received_milts', {
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
        console.log(this.exchangedMiltsTarget);
        console.log(data);
        if (data.update_milts_count) {
          this.exchangedMiltsTarget.innerHTML = data.update_milts_count
        }
      })
  }

  addSentMilts() {
    fetch('/add_sent_milts', {
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
