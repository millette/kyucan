"use strict"

// core
const { dirname } = require("path")

module.exports = { includePaths: [dirname(require.resolve("bulma"))] }
