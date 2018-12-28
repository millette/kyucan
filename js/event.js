"use strict"

// TODO: use dynamic import for code splitting
//       might require bublé
import eventData from "../event-data.json"
import eventVotes from "../votes.json"

const dates = eventVotes
  .map(({ moments }) =>
    moments
      .filter(({ local }) => local)
      .map(({ local, preference }) => ({ local, preference })),
  )
  .reduce((a, b) => [...a, ...b], [])

const prefs = (opts) => {
  if (!opts.top) opts.top = 3
  const byDates = {}
  dates.forEach(({ local, preference }) => {
    if (!byDates[local]) byDates[local] = []
    byDates[local].push(preference)
  })
  const z = []
  let r
  for (r in byDates) {
    let score = byDates[r].reduce((a, b) => a + b, 0)
    let n = byDates[r].length
    z.push({
      pref: 1,
      local: r,
      n,
      score,
      avg: (n + score) / 2,
    })
  }
  return z
    .sort((a, b) => {
      if (a.avg > b.avg) return 1
      if (a.avg < b.avg) return -1
      return 0
    })
    .slice(-opts.top)
    .sort((a, b) => {
      if (a.local > b.local) return 1
      if (a.local < b.local) return -1
      return 0
    })
}

module.exports = {
  init: function(opts) {
    this.eventData = eventData
    this.eventVotes = eventVotes
    this.eventDates = dates
    this.eventPrefs = prefs(opts)
  },
}
