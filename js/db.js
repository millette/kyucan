"use strict"

import { db } from "../config.json"

const cryptoObj = window.crypto || window.msCrypto

const makeId = (len) =>
  Array.from(cryptoObj.getRandomValues(new Uint8Array(len)))
    .map((b) => b.toString(16).padStart(2, "0"))
    .join("")

const get = (u) =>
  fetch(u, { headers: { accept: "application/json" } }).then((res) =>
    res.json(),
  )

module.exports = {
  uniqueId: function uniqueId(id2) {
    if (id2) {
      this.dbUrl = db.slice(0, -id2.length) + id2
      return id2
    }
    const id = makeId(8)
    const w = db.slice(0, -id.length) + id
    return get(w).then((so) => {
      if (so.result !== null) return uniqueId()
      this.dbUrl = w
      return id
    })
  },
  dbPost: function(type, data, id) {
    if (!this.dbUrl) throw new Error("Call uniqueId() first")
    return fetch([this.dbUrl, type, id || data._id].join("/"), {
      headers: { "Content-type": "application/json" },
      method: "POST",
      body: JSON.stringify(data),
    }).then((res) => res.json())
  },
  dbGet: function(type, data, id) {
    if (!this.dbUrl) throw new Error("Call uniqueId() first")
    return get([this.dbUrl, type, id || data._id].join("/"))
  },
}
