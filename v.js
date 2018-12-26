"use strict"

const voters = require("./votes-v4.json").map(({ moments }) =>
  moments.filter(({ local }) => local),
)

const votes = voters.reduce((a, b) => [...a, ...b], [])

const groups = {}

votes.forEach(({ local, preference }) => {
  if (!groups[local]) {
    groups[local] = []
  }
  groups[local].push(preference + 0.5)
})

// console.log(groups)

const sorted = []
let local
for (local in groups) {
  let sum = groups[local].reduce((a, b) => a + b, 0)
  let mul = groups[local].reduce((a, b) => a * b, 1)
  // console.log(r, sum, mul)
  sorted.push({
    n: groups[local].length,
    local,
    sum,
    mul,
  })
}

/*
 * 1.5    1.5
 * 4.0    2.31
 * 2.7    1.82
 *
 */

// console.log(sorted)

const byMul = sorted
  .sort((a, b) => {
    const qa = a.mul
    const qb = b.mul

    if (qa > qb) return 1
    if (qa < qb) return -1
    return 0
  })
  .reverse()
  .map(({ local, mul }) => ({ local, mul }))

const bySum = sorted
  .sort((a, b) => {
    const qa = a.sum
    const qb = b.sum

    if (qa > qb) return 1
    if (qa < qb) return -1
    return 0
  })
  .reverse()
  .map(({ local, sum }) => ({ local, sum }))

const byN = sorted
  .sort((a, b) => {
    const qa = a.n
    const qb = b.n

    if (qa > qb) return 1
    if (qa < qb) return -1
    return 0
  })
  .reverse()
  .map(({ local, n }) => ({ local, n }))

/*
console.log("sums:", bySum)
console.log("n:", voters.length, byN)
console.log("muls:", byMul)
*/

console.log(
  JSON.stringify(
    {
      bySum,
      byN,
      byMul,
    },
    null,
    "  ",
  ),
)

/*

sums:
[ { local: '2019-01-12T08:10', sum: 4.5 },
  { local: '2019-01-13T08:10', sum: 3.85 },
  { local: '2019-01-11T08:10', sum: 1.45 }
]

n: 4
[ { local: '2019-01-12T08:10', n: 4 },
  { local: '2019-01-13T08:10', n: 3 },
  { local: '2019-01-11T08:10', n: 1 }
]
muls:
[ { local: '2019-01-13T08:10', mul: 2.109375 },
  { local: '2019-01-12T08:10', mul: 1.51869375 },
  { local: '2019-01-11T08:10', mul: 1.45 }
]

                  sums    n     muls
2019-01-12T08:10  4.5     4     1.52
2019-01-13T08:10  3.85    3     2.11
2019-01-11T08:10  1.45    1     1.45

*/
