import { Controller } from "@hotwired/stimulus"
import { Toast, ToastType } from "../helpers/toast"

// Connects to data-controller="category"
export default class extends Controller {
  static targets = ["active"]

  toggle(event) {
    const id = this.data.get("id")
    const csrfToken = document.querySelector("[name='csrf-token']").content

    fetch(`/categories/${id}/toggle`, {
      method: 'POST',
      mode: "cors",
      cache: "no-cache",
      credentials: 'same-origin',
      dataType: 'script',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({ active: event.target.checked })
    }).then(response => response.json())
      .then(() => {
        new Toast('Status modificado com sucesso', ToastType.Success, 3000)
      })
  }
}
