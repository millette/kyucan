"use strict"

module.exports = {
  init: function(opts) {
    const x = document.querySelectorAll("#mainnav .navbar-item")[opts.navid]
    if (!x) throw new Error("Missing navid attribute.")

    this.on("mount", () => {
      const rem = document.querySelector("#mainnav .navbar-item.is-active")
      if (rem) rem.classList.remove("is-active")
      x.classList.add("is-active")
    })
  },
}
