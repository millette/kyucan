import nanoid from "nanoid"

module.exports = {
  // For collision probability see https://zelark.github.io/nano-id-cc/
  uniqueId: (len = 4) =>
    nanoid(len)
      .replace(/[_-]+/g, "-") // remove all sequences of _ and - by single -
      .replace(/^[-0-9]+/g, "") // don't begin with number or -
      .replace(/-+$/g, ""), // don't end with -
}
