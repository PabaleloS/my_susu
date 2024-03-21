import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="susu-subscription"
export default class extends Controller {
  static values = { susuId: Number, currentUserId: Number }
  static targets = ["messages"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "SusuChannel", id: this.susuIdValue },
      { received: data => this.#insertMessageAndScrollDown(data) }
    )
    console.log(`Subscribed to the Susu susu with the id ${this.susuIdValue}.`)
  }

  #insertMessageAndScrollDown(data) {
    const currentUserIsSender = this.currentUserIdValue === data.sender_id
    const messageElement = this.#buildMessageElement(currentUserIsSender, data.message)

    this.messagesTarget.insertAdjacentHTML("beforeend", messageElement)
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)

    // Play a sound when a new message is inserted
    this.#playMessageSound();
  }

  // Function to play the message sound
  #playMessageSound() {
    const audio = new Audio('app/assets/mixkit-message-pop-alert-2354.mp3'); 
    audio.play();
  }

  resetForm(event) {
    event.target.reset()
  }

  disconnect() {
    console.log("Unsubscribed from the Susu susu")
    this.channel.unsubscribe()
  }

  #buildMessageElement(currentUserIsSender, message) {
    return `
      <div class="message-row d-flex ${this.#justifyClass(currentUserIsSender)}">
        <div class="${this.#userStyleClass(currentUserIsSender)}">
          ${message}
        </div>
      </div>
    `
  }

  #justifyClass(currentUserIsSender) {
    return currentUserIsSender ? "justify-content-end" : "justify-content-start"
  }

  #userStyleClass(currentUserIsSender) {
    return currentUserIsSender ? "sender-style" : "receiver-style"
  }
}











// import { Controller } from "@hotwired/stimulus"
// import { createConsumer } from "@rails/actioncable"

// // Connects to data-controller="susu-subscription"
// export default class extends Controller {
//   static values = { susuId: Number, currentUserId: Number }
//   static targets = ["messages"]

//   connect() {
//     this.channel = createConsumer().subscriptions.create(
//       { channel: "SusuChannel", id: this.susuIdValue },
//       { received: data => this.#insertMessageAndScrollDown(data) }
//     )
//     console.log(`Subscribed to the Susu susu with the id ${this.susuIdValue}.`)
//   }

//   // #insertMessageAndScrollDown(data) {
//   //   const currentUserIsSender = this.currentUserIdValue === data.sender_id
//   //   this.messagesTarget.insertAdjacentHTML("beforeend", data)
//   //   this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)

//   // }

//   #insertMessageAndScrollDown(data) {
//     // Logic to know if the sender is the current_user
//     const currentUserIsSender = this.currentUserIdValue === data.sender_id
//     // Creating the whole message from the `data.message` String
//     const messageElement = this.#buildMessageElement(currentUserIsSender, data.message)

//     console.log({ messageElement })

//     // Inserting the `message` in the DOM
//     this.messagesTarget.insertAdjacentHTML("beforeend", messageElement)
//     this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
//   }



//   resetForm(event) {
//     event.target.reset()
//   }

//   disconnect() {
//     console.log("Unsubscribed from the Susu susu")
//     this.channel.unsubscribe()
//   }

//   #buildMessageElement(currentUserIsSender, message) {
//     return `
//       <div class="message-row d-flex ${this.#justifyClass(currentUserIsSender)}">
//         <div class="${this.#userStyleClass(currentUserIsSender)}">
//           ${message}
//         </div>
//       </div>
//     `
//   }

//   #justifyClass(currentUserIsSender) {
//     return currentUserIsSender ? "justify-content-end" : "justify-content-start"
//   }

//   #userStyleClass(currentUserIsSender) {
//     return currentUserIsSender ? "sender-style" : "receiver-style"
//   }

// }
