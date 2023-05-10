export class Toast {
    constructor(message, color, time) {
        this.message = message;
        this.color = color;
        this.time = time;
        this.element = null;

        let container = document.createElement('div')
        container.className = 'toast toast-end m-2'

        var countElements = document.getElementsByClassName("toast");

        container.style.opacity = 0.8;

        container.style.marginBottom = (countElements.length * 60) + "px";

        let alert = document.createElement('div')
        alert.className = `alert ${color}`

        var message = document.createElement("div");
        message.textContent = this.message;

        alert.appendChild(message)

        container.appendChild(alert);

        document.body.appendChild(container);

        setTimeout(function () {
            container.remove();
        }, this.time);

        /*  close.addEventListener("click", () => {
             element.remove();
         }) */
    }

}

export const ToastType = {
    Danger: "alert-error",
    Warning: "alert-warning",
    Success: "alert-success",
}
