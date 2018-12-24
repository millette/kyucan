"use strict"

// TODO: use dynamic import for code splitting
//       might require bublé
import pkg from "../package.json"
import pkgRiot from "riot/package.json"
import pkgBulma from "bulma/package.json"
import pkgParcel from "parcel-bundler/package.json"
import pkgPrettier from "prettier/package.json"

module.exports = {
  getPkgs: () => [pkgRiot, pkgBulma, pkgParcel, pkgPrettier],
  self: () => pkg,
}
