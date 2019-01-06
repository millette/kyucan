"use strict"

import { db, idLength } from "../config.json"

const cryptoObj = window.crypto || window.msCrypto
const len = Math.max(Math.min(idLength || 8, 64), 1)

const makeId = () =>
  Array.from(cryptoObj.getRandomValues(new Uint8Array(len)))
    .map((b) => b.toString(16).padStart(2, "0"))
    .join("")

const get = (u) =>
  fetch(u, { headers: { accept: "application/json" } }).then((res) =>
    res.json()
  )

module.exports = {
  makeId,
  uniqueId: function uniqueId(id) {
    const noId = !id
    if (noId) id = makeId()
    const w = db.slice(0, -id.length) + id
    if (!noId) {
      this.dbUrl = w
      return id
    }
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
  dbGet: function(type, id) {
    if (!this.dbUrl) throw new Error("Call uniqueId() first")
    return get([this.dbUrl, type, id].join("/"))
  },
}
