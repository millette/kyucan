"use strict"

const cryptoObj = window.crypto || window.msCrypto

module.exports = {
  uniqueId: (len = 8) =>
    Array.from(cryptoObj.getRandomValues(new Uint8Array(len)))
      .map((b) => b.toString(16).padStart(2, "0"))
      .join(""),
}
