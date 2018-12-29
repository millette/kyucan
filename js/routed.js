"use strict"

module.exports = {
  init: function(opts) {
    this.on("route", () => {
      const x = document.querySelectorAll(
        ".menu.is-pulled-right > .menu-list > li > a",
      )
      x.forEach((y) => y.classList.remove("is-active"))
      x[opts.page || 0].classList.add("is-active")
    })
  },
}
