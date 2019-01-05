"use strict"

import { db } from "../config.json"

module.exports = {
  dbPost: (type, data, id) =>
    fetch([db, type, id || data._id].join("/"), {
      headers: { "Content-type": "application/json" },
      method: "POST",
      body: JSON.stringify(data),
    }).then((res) => res.json()),
  dbGet: (type, data, id) =>
    fetch([db, type, id || data._id].join("/"), {
      headers: { accept: "application/json" },
    }).then((res) => res.json()),
}
