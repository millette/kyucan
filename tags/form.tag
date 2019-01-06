<form-tag>
  <section class="section">
    <div class="container">
      <div class="columns">
        <div class="column">
          <event-tag event="{eventData}" />
          <instructions-tag />
        </div>

        <div class="column is-narrow">
          <vote-form
            submit="{submit}"
            event-prefs="{eventPrefs}"
            event-data="{eventData}"
            add-date="{addDate}"
            set-show="{setShow}"
          />
        </div>
        <div if="{show}" class="column">
          <article class="message is-warning">
            <div class="message-header">
              <h3 id="choices">Mes choix</h3>
              <button
                onclick="{deleteMessage}"
                class="delete"
                aria-label="delete"
              ></button>
            </div>
            <div class="message-body content">
              <dl>
                <dt>Nom</dt>
                <dd>{name}</dd>
              </dl>
              <virtual if="{email}">
                <dl>
                  <dt>Email</dt>
                  <dd>{email}</dd>
                </dl>
              </virtual>
              <virtual each="{datesGiven}">
                <dl>
                  <dt>Quand</dt>
                  <dd>
                    {date} <span if="{time}"> à {time} (heure locale)</span>
                    <span if="{offset}"> ({offset})</span>
                  </dd>
                  <dd if="{utcTime}"><small>{utcTime}</small></dd>

                  <dt>Préférence</dt>
                  <dd>{preference}</dd>
                </dl>
              </virtual>

              <button
                onclick="{confirm}"
                type="button"
                class="button is-success is-fullwidth"
              >
                Confirmer
              </button>
            </div>
          </article>
        </div>
      </div>
    </div>
  </section>

  <style>
    fieldset {
      overflow-y: scroll;
      max-height: 25rem;
    }

    label.checkbox {
      color: black;
      display: block;
    }

    dt {
      font-weight: bold;
    }
  </style>

  <script>
    this.mixin("db")
    this.mixin("store")
    this.mixin("event")
    this.mixin("routed")
    this.show = false
    this.datesGiven = []

    this.on('*', (c) => console.log('ON-FORM', c, this.eventData))

    // console.log('FOR-STORE:', this.storeGet('event'))
    this.eventData = this.storeGet('event')
    console.log('FOR-STORE::EVENTDATA#1:', this.eventData, this.dbUrl)
    // console.log('EL-DB:', this.storeGet('db'))

    shouldUpdate(data, nextOpts) {
      console.log('SHOULD#1?', data, nextOpts)
      return true
    }

    if (!this.eventData) {
      const [p, h] = window.location.hash.slice(1).split('/')
      console.log('HASH:', h, p)
      if (p !== 'vote') throw new Error('Unexpected path')

      setTimeout(() => {
        console.log('DO IT!')
        // const eventData2 = {
        this.eventData = {
          "_id": "d021b800c9576538",
          "description": "",
          "duration": 60,
          "from": "2019-01-05",
          "initialDates": [{
              "date": "2019-01-05",
              "preference": "100%",
              "time": "12:00",
              "utcTime": "2019-01-05T17:00:00 UTC"
          }, {
              "date": "2019-01-06",
              "preference": "100%",
              "time": "12:00",
              "utcTime": "2019-01-06T17:00:00 UTC"
          }],
          "instigator": "dsa",
          "location": "",
          "offset": "UTC-0500",
          "step": 900,
          "title": "",
          "until": "2019-01-23",
          "url": ""
        }
        // console.log('TAGS:', this.tags)
        this.tags['vote-form'].update({ eventData: this.eventData })
        this.tags['event-tag'].update({ eventData: this.eventData })
        // this.update({ eventData: eventData2 })
        this.update()
        // riot.update({ eventData: this.eventData })

        /*
        {
          eventData: {
            "_id": "d021b800c9576538",
            "description": "",
            "duration": 60,
            "from": "2019-01-05",
            "initialDates": [{
                "date": "2019-01-05",
                "preference": "100%",
                "time": "12:00",
                "utcTime": "2019-01-05T17:00:00 UTC"
            }, {
                "date": "2019-01-06",
                "preference": "100%",
                "time": "12:00",
                "utcTime": "2019-01-06T17:00:00 UTC"
            }],
            "instigator": "dsa",
            "location": "",
            "offset": "UTC-0500",
            "step": 900,
            "title": "",
            "until": "2019-01-23",
            "url": ""
          }
        }
        */
      }, 100)

    }

    this.on('route', (name) => {
      this.uniqueId(name)
    })

    /*
    this.on('route', (name) => {
      // this.name = name
      console.log('ROUTE555', name)
      this.uniqueId(name)
      this.eventData = {
        "_id": "d021b800c9576538",
        "description": "",
        "duration": 60,
        "from": "2019-01-05",
        "initialDates": [{
            "date": "2019-01-05",
            "preference": "100%",
            "time": "12:00",
            "utcTime": "2019-01-05T17:00:00 UTC"
        }, {
            "date": "2019-01-06",
            "preference": "100%",
            "time": "12:00",
            "utcTime": "2019-01-06T17:00:00 UTC"
        }],
        "instigator": "dsa",
        "location": "",
        "offset": "UTC-0500",
        "step": 900,
        "title": "",
        "until": "2019-01-23",
        "url": ""
      }

      console.log('FOR-STORE::EVENTDATA#2:', this.eventData, this.dbUrl)
      this.update()
    })
    */

    confirm(ev) {
      // const db = this.storeGet('db')
      console.log('CONFIRM')

      const ps = []
      if (this.eventData.creating) {
        const event = {
          ...this.eventData,
          initialDates: this.datesGiven
        }
        delete event.creating
        ps.push(this.dbPost('event', event))
        console.log('FULL-EVENT:', event)
      }

      const vote = {
        _id: this.makeId(),
        name: this.name,
        email: this.email,
        initialDates: this.datesGiven,
        eventId: this.eventData._id
      }
      console.log('FULL-VOTE:', vote)

      /*
      this.dbPost('vote', vote)
        .then(({ ok }) => {
          if (!ok) throw new Error('bad bad')
          console.log('All good!', this.dbUrl)
          // We're good!
        })
        .catch((e) => {
          console.error(e)
          // We're not good!
        })
      */

      ps.push(this.dbPost('vote', vote))
      /*
      Promise.all([
        this.dbPost('event', event),
        // this.dbPost('vote', vote, `${event._id}--${vote._id}`)
        this.dbPost('vote', vote)
      ])
      */
      Promise.all(ps)
        .then((zz) => {
          if (!zz || !zz.length || (zz.filter(({ ok }) => ok).length !== zz.length))
            throw new Error('bad bad')

          // We're good!
          console.log('All good!', this.dbUrl)
        })
        .catch((e) => {
          console.error(e)
          // We're not good!
        })
    }

    setShow(show, datesGiven, name, email) {
      this.show = show
      if (datesGiven) this.datesGiven = datesGiven.filter(({ preference }) => preference)
      if (name) this.name = name
      if (email) this.email = email
      this.update()
      if (show) document.getElementById('choices').scrollIntoView({ behavior: 'smooth' })
    }

    deleteMessage() { this.show = false }
  </script>
</form-tag>
