<form-tag>
  <section class="section">
    <div class="container">
      <div class="columns">
        <div class="column">
          <event-tag event="{eventData}" />
          <instructions-tag />
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
                  placeholder="Nom complet, prénom ou alias"
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
            <p
              if="{!showDates}"
              class="has-pointer collapser"
              onclick="{collapse}"
            >
              Ajouter des dates et des heures
            </p>

            <fieldset if="{showDates}">
              <legend onclick="{collapse}" class="has-pointer">
                Ajouter des dates et des heures
              </legend>
              <virtual each="{dates}">
                <div class="field">
                  <label class="label">Date #{n}</label>
                  <div class="control">
                    <input
                      required="{n === 1}"
                      ref="date"
                      class="input"
                      type="date"
                      value="{n === 1 ? lastDate : ''}"
                      min="{eventData.from}"
                      max="{eventData.until}"
                    />
                  </div>
                </div>
                <div class="field">
                  <label class="label">Heure</label>
                  <div class="control">
                    <input
                      onchange="{timeChange}"
                      ref="time"
                      class="input"
                      type="time"
                      min="00:00"
                      max="23:45"
                      step="{eventData.step}"
                    />
                  </div>
                </div>
                <div class="field">
                  <label class="label level is-mobile">
                    <small class="level-item">si nécessaire</small>
                    <div class="level-item">Préférence</div>
                    <small class="level-item">absolument</small>
                  </label>
                  <div class="control">
                    <input
                      ref="preference"
                      class="input"
                      type="range"
                      value="1"
                      min="0.5"
                      max="1"
                      step="0.05"
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
    this.mixin("event")
    this.show = false
    this.showDates = true
    this.datesGiven = []
    this.dates = [
      {
        n: 1,
        lastDate: this.eventData.from
      }
    ]

    collapse() { this.showDates = !this.showDates }

    deleteMessage() { this.show = false }

    timeChange(ev) {
      // chrome handles the step attribute correctly
      // but firefox doesn't so we handle it here
      if (!ev.target.value) return
      const [h, m] = ev.target.value.split(':')
      const step = Math.round(ev.target.step / 60)
      if (m % step) {
        const nm = `${(step * Math.ceil(m / step)) % 60}`.padStart(2, '0')
        ev.target.value = `${h}:${nm}`
      }
    }

    addDate(e) {
      e.preventUpdate = true
      const dates = Array.isArray(this.refs.date) ? [...this.refs.date] : [this.refs.date]
      const date = dates.pop()
      if (date.value) {
        this.dates.push({
          n: dates.length + 2,
          lastDate: date.value
        })
      }
      this.update()

      this.refs.date.slice(-1)[0].focus()
      this.refs.time.slice(-1)[0].scrollIntoView({
        behavior: 'smooth',
        block: 'nearest'
      })
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

    const makeOffset = () => {
      const xx0 = 100 * new Date().getTimezoneOffset() / 60
      const xx = `${xx0}`.padStart(4, '0')
      const s = xx0 < 0 ? '+' : '-'
      return `UTC${s}${xx}`
    }

    const offset = makeOffset()

    const boop = (d, t) => new Date(`${d}T${t}`).toISOString().split('.')[0] + ' UTC'

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
      e.preventUpdate = true
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
      this.update()
      document.getElementById('choices').scrollIntoView({ behavior: 'smooth' })
    }

    if (!window.location.hash) setTimeout(() => this.refs.name.focus())
  </script>
</form-tag>
