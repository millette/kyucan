"use strict"

/*
[
  {
    "name": "ro",
    "moments": [
      {
        "local": "2019-01-13T08:10",
        "utc": "2019-01-13T13:10",
        "preference": 0.8
      },
      {
        "local": "2019-01-12T08:10",
        "utc": "2019-01-12T13:10",
        "preference": 0.5
      }
    ]
  }
]
*/

const nFirstMoments = 3
const nParticipants = 10
const pNewMoment = 0.2
const step = 900

const earliest = Date.parse("2019-01-10T13:10Z")
const latest = Date.parse("2019-01-14T13:10Z")
const covers = latest - earliest

const generateMoment = () =>
  new Date(
    Math.floor((Math.random() * covers + earliest) / (step * 1000)) *
      (step * 1000),
  ).toISOString()

const generateFirst = () => {
  const moments = []
  let r
  for (r = 0; r < nFirstMoments; ++r) {
    moments.push(generateMoment())
  }
  return moments.sort()
}

const first = generateFirst()

// const x = generateFirst()
// console.log(x)

const userVotes = () => {
  const votes = []
  let r
  const m = Math.floor(Math.random() * 5 + 1)

  for (r = 0; r < m; ++r) {
    let mom
    if (Math.random() < pNewMoment) {
      mom = generateMoment()
      if (!first.includes(mom)) first.push(mom)
    } else {
      mom = first[Math.floor(Math.random() * first.length)]
    }
    const preference = Math.random() * 0.5 + 0.5
    if (!votes.find((el) => el.local === mom))
      votes.push({ local: mom, preference })
  }
  return votes.sort((a, b) => {
    if (a.preference > b.preference) return 1
    if (a.preference < b.preference) return -1
    return 0
  })
}

const allUserVotes = () => {
  const votes = []
  let r
  const m = Math.floor(Math.random() * 5 + 1)
  for (r = 0; r < nParticipants; ++r) {
    votes.push({ name: `name-${r + 1}`, moments: userVotes() })
  }
  return votes
}

console.log(JSON.stringify(allUserVotes()))
