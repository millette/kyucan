// npm
import riot from "riot"

// self
import "../tags/app.tag"
import "../tags/hero.tag"
import "../tags/event.tag"
import "../tags/instructions.tag"
import "../tags/colophon.tag"
import "../tags/pkg.tag"
import "../tags/form.tag"
import "../tags/footer.tag"

// TODO: use dynamic import for code splitting
//       might require bublé
import pkg from "../package.json"
import pkgRiot from "riot/package.json"
import pkgBulma from "bulma/package.json"
import pkgParcel from "parcel-bundler/package.json"
import pkgPrettier from "prettier/package.json"

riot.mixin("oy", {
  init: function(opts) {
    console.log("OY-INIT-OPTS:", opts)
    console.log("OY-INIT-THIS:", this)
    this.oy = { booya: 666 }
  },
  getPkgs: () => [pkgRiot, pkgBulma, pkgParcel, pkgPrettier],
  self: () => pkg,
})

riot.mount("app")
