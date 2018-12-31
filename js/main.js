// npm

import riot from "riot"
import route from "riot-route/lib/tag" // note that the path is bit different to cjs one

// self
import "../tags/index.js"
import commithash from "../more/git-master-head.txt"
import oy from "./oy.js"
import event from "./event.js"
import routed from "./routed.js"

riot.mixin("oy", oy)
riot.mixin("event", event)
riot.mixin("routed", routed)
riot.mount("app", { commithash })
