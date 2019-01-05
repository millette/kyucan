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

    // console.log('FOR-STORE:', this.storeGet('event'))
    this.eventData = this.storeGet('event')
    // console.log('EL-DB:', this.storeGet('db'))

    this.on('route', (name, b, c) => {
      // this.name = name
      console.log('ROUTE555', name, b, c, this.opts)
      this.uniqueId(name)
    })

    confirm(ev) {
      // const db = this.storeGet('db')
      console.log('CONFIRM')
      const event = {
        ...this.eventData,
        initialDates: this.datesGiven
      }
      delete event.creating
      console.log('FULL-EVENT:', event)

      const vote = {
        // _id: this.uniqueId(),
        name: this.name,
        email: this.email,
        initialDates: this.datesGiven,
        eventId: this.eventData._id
      }
      console.log('FULL-VOTE:', vote)

      Promise.all([
        this.dbPost('event', event),
        this.dbPost('vote', vote, `${event._id}--${vote._id}`)
      ])
        .then((zz) => {
          if (!zz || !zz.length || (zz.filter(({ ok }) => ok).length !== zz.length))
            throw new Error('bad bad')

          // We're good!
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
