"use strict"

module.exports = {
  init: function(opts) {
    const x = document.querySelectorAll("#mainnav > li > a")[opts.navid]
    if (!x) throw new Error("Missing navid attribute.")

    this.on("mount", () => {
      const rem = document.querySelector("#mainnav > li > a.is-active")
      if (rem) rem.classList.remove("is-active")
      x.classList.add("is-active")
    })
  },
}
