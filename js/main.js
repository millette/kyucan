// npm
import riot from "riot"
import route from "riot-route/lib/tag" // note that the path is bit different to cjs one

// self
import "../tags/app.tag"
import "../tags/hero.tag"
import "../tags/event.tag"
import "../tags/instructions.tag"
import "../tags/colophon.tag"
import "../tags/pkg.tag"
import "../tags/form.tag"
import "../tags/vote-form.tag"
import "../tags/footer.tag"
import oy from "./oy.js"
import event from "./event.js"
import routed from "./routed.js"

riot.mixin("oy", oy)
riot.mixin("event", event)
riot.mixin("routed", routed)
riot.mount("app")
