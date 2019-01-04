// npm

import riot from "riot"
import route from "riot-route/lib/tag"

// self
import "../tags/index.js"
import commithash from "../more/git-master-head.txt"
import oy from "./oy.js"
import event from "./event.js"
import routed from "./routed.js"
import localDate from "./local-date.js"
import uniqueId from "./unique-id.js"
import store from "./store.js"

riot.mixin("store", store)
riot.mixin("oy", oy)
riot.mixin("event", event)
riot.mixin("routed", routed)
riot.mixin("localDate", localDate)
riot.mixin("uniqueId", uniqueId)
riot.mount("app", { commithash, store: new Map() })
