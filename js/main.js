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
import oy from "./oy.js"

riot.mixin("oy", oy)
riot.mount("app")
