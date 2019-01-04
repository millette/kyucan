"use strict"

module.exports = {
  storeGet: function(k) {
    return this.parent.parent.opts.store.get(k)
  },
  storeSet: function(k, v) {
    return this.parent.parent.opts.store.set(k, v)
  },
}
