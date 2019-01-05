// import nanoid from "nanoid"

const cryptoObj = window.crypto || window.msCrypto

const buf2hex = (buffer) =>
  Array.prototype.map
    .call(buffer, (x) => ("00" + x.toString(16)).slice(-2))
    .join("")

module.exports = {
  uniqueId: (len = 8) =>
    buf2hex(cryptoObj.getRandomValues(new Uint8Array(len))),
}

/*
module.exports = {
  // For collision probability see https://zelark.github.io/nano-id-cc/
  uniqueId: (len = 4) =>
    nanoid(len)
      .replace(/[_-]+/g, "-") // remove all sequences of _ and - by single -
      .replace(/^[-0-9]+/g, "") // don't begin with number or -
      .replace(/-+$/g, ""), // don't end with -
}
*/
