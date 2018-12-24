"use strict"

// TODO: use dynamic import for code splitting
//       might require bublé
import eventData from "../event-data.json"

module.exports = {
  init: function() {
    this.eventData = eventData
  },
}
