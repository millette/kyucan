"use strict"

module.exports = {
  init: function() {
    const xx0 = (100 * new Date().getTimezoneOffset()) / 60
    const xx = `${xx0}`.padStart(4, "0")
    const s = xx0 < 0 ? "+" : "-"
    this.offset = `UTC${s}${xx}`
  },
  localDate: (day) => {
    if (!day) day = new Date()
    const year = day.getUTCFullYear()
    const month = `${day.getUTCMonth() + 1}`.padStart(2, "0")
    const d = `${day.getUTCDate()}`.padStart(2, "0")
    return `${year}-${month}-${d}`
  },
}
