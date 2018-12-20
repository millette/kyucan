console.log("Hello#1")
import riot from "riot"

console.log("Hello#2")
import "./app.tag"
import "./footer.tag"

console.log("Hello#3")
const x = riot.mount("app")

console.log("Hello#4", x)
