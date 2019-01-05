"use strict"

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
import store from "./store.js"
import db from "./db.js"

riot.mixin("store", store)
riot.mixin("db", db)
riot.mixin("oy", oy)
riot.mixin("event", event)
riot.mixin("routed", routed)
riot.mixin("localDate", localDate)
riot.mount("app", { commithash, store: new Map() })
