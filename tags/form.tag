<form-tag>
  <section class="section">
    <div class="container">
      <div class="columns">
        <div class="column">
          <event-tag duration="90" />
          <instructions-tag />
          <colophon-tag foo="boo" />
        </div>

        <div class="column">
          <form class="box" onsubmit="{submit}">
            <div class="field">
              <label class="label">Nom</label>
              <div class="control">
                <input
                  ref="name"
                  required
                  class="input is-danger"
                  type="text"
                  placeholder="Full name or first name"
                  oninvalid="{invalid}"
                  onchange="{ok}"
                />
              </div>
            </div>

            <div class="field">
              <label class="label">Email</label>
              <div class="control">
                <input
                  ref="email"
                  class="input"
                  type="email"
                  placeholder="name@example.com"
                  oninvalid="{invalid}"
                />
              </div>
            </div>
            <p if="{!showDates}" class="collapser" onclick="{collapse}">
              Ajouter des dates et des heures
            </p>

            <fieldset if="{showDates}">
              <legend onclick="{collapse}">
                Ajouter des dates et des heures
              </legend>
              <virtual each="{dates}">
                <div class="field">
                  <label class="label">Date #{n}</label>
                  <div class="control">
                    <input
                      ref="date"
                      class="input"
                      type="date"
                      value="{lastDate}"
                    />
                  </div>
                </div>
                <div class="field">
                  <label class="label">Heure</label>
                  <div class="control">
                    <input ref="time" class="input" type="time" />
                  </div>
                </div>
                <div class="field">
                  <label class="label level">
                    <small class="level-item"> impossible </small>
                    <div class="level-item">Préférence</div>
                    <small class="level-item"> absolument </small>
                  </label>
                  <div class="control">
                    <input
                      ref="preference"
                      class="input"
                      type="range"
                      value="1"
                      min="0"
                      max="1"
                      step="0.04"
                    />
                  </div>
                </div>
              </virtual>
              <div class="control">
                <button
                  onclick="{addDate}"
                  type="button"
                  class="content button is-info"
                >
                  Ajouter d'autres dates
                </button>
              </div>
            </fieldset>
            <div class="control">
              <button class="content button is-primary is-fullwidth">
                2<sup>e</sup>&nbsp;étape →
              </button>
            </div>
          </form>
        </div>
        <div if="{show}" class="column">
          <article class="message is-primary">
            <div class="message-header">
              <p>Mes choix</p>
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

    input[type="range"] {
      margin-bottom: 1rem;
    }

    .collapser {
      color: black;
      margin-bottom: 1rem;
    }

    dt {
      font-weight: bold;
    }
  </style>

  <script>
    const tomorrow = new Date(Date.now() + 86400000)
    const makeOffset = () => {
      const xx0 = 100 * tomorrow.getTimezoneOffset() / 60
      const xx = `${xx0}`.padStart(4, '0')
      const s = xx0 < 0 ? '+' : '-'
      return `UTC${s}${xx}`
    }

    const offset = makeOffset()
    this.show = false
    this.datesGiven = []
    this.dates = [
      {
        n: 1,
        lastDate: `${tomorrow.getFullYear()}-${tomorrow.getMonth() + 1}-${tomorrow.getDate()}`
      }
    ]

    const boop = (d, t) => new Date(`${d}T${t}`).toISOString().split('.')[0] + ' UTC'

    this.showDates = true

    collapse() { this.showDates = !this.showDates }

    deleteMessage() { this.show = false }

    addDate() {
      const dates = Array.isArray(this.refs.date) ? [...this.refs.date] : [this.refs.date]
      const date = dates.pop()
      if (date.value) {
        this.dates.push({
          n: dates.length + 2,
          lastDate: date.value
        })
      }
      this.update()
      this.refs.time.slice(-1)[0].scrollIntoView()
      this.refs.date.slice(-1)[0].focus()
    }

    ok(e) {
      const name = e.target.classList
      name.remove('is-danger')
      if (this.refs.name.value) {
        name.add('is-success')
      } else {
        name.add('is-danger')
        name.remove('is-success')
      }
    }

    invalid(e) {
      this.refs.email.classList.remove('is-danger')
      if (this.refs.email.value) this.refs.email.classList.add('is-success')
      e.target.classList.add('is-danger')
    }

    const parseDates = (times, date, i) => {
      if (!date.value) return

      const preferences = Array.isArray(this.refs.preference)
        ? this.refs.preference.map((x) => x.valueAsNumber)
        : [this.refs.preference.valueAsNumber]

      const o = {
        date: date.value,
        preference: `${100 * preferences[i]}%`
      }

      if (times[i].value) {
        o.time = times[i].value
        o.utcTime = boop(o.date, o.time)
      } else {
        o.offset = offset
      }
      this.datesGiven.push(o)
    }

    submit(e) {
      e.preventDefault()

      this.refs.name.classList.remove('is-danger')
      this.refs.email.classList.remove('is-danger')
      this.refs.name.classList.add('is-success')
      if (this.refs.email.value) this.refs.email.classList.add('is-success')
      this.name = this.refs.name.value
      this.email = this.refs.email.value
      const dates = Array.isArray(this.refs.date) ? this.refs.date : [this.refs.date]
      const times = Array.isArray(this.refs.time) ? this.refs.time : [this.refs.time]
      this.datesGiven = []
      dates.forEach(parseDates.bind(this, times))
      let str = `Kyucan - ${this.name}`
      if (this.datesGiven.length) str += (this.datesGiven.length === 1) ? ` (un moment)` : ` (${this.datesGiven.length} moments)`

      document.title = str
      this.show = true
    }

    setTimeout(() => this.refs.name.focus())
  </script>
</form-tag>
