<vote-form>
  <p if="{loadingError}">{loadingError}</p>
  <form if="{!loadingError}" class="box" onsubmit="{submit}">
    <div class="field">
      <label class="label">Nom</label>
      <div class="control">
        <input
          ref="name"
          required
          class="input is-danger"
          type="text"
          value="{(this.eventData.creating ? eventData.instigator : '')}"
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

    <fieldset if="{eventPrefs}">
      <legend>Mes choix</legend>
      <virtual each="{eventPrefs}">
        <label class="checkbox">
          <input type="checkbox" onchange="{pickPref}" /> {local.replace('T', '
          à ')}
        </label>

        <div if="{picked}">
          <preference-tag set-preference="{setPreference}" />
        </div>
      </virtual>
    </fieldset>

    <p if="{!showDates}" class="has-pointer collapser" onclick="{collapse}">
      Ajouter des dates et des heures
    </p>

    <fieldset class="{showDates ? '' : 'is-hidden'}">
      <legend
        onclick="{eventData.creating || collapse}"
        class="{eventData.creating || 'has-pointer'}"
      >
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
              value="12:00"
              min="00:00"
              max="23:45"
              step="{eventData.step}"
            />
          </div>
        </div>
        <preference-tag
          isno="{(!eventData.creating && (n === 1))}"
          ref="{(`preference-${this.n}`)}"
        />
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
      <button class="content button is-primary is-fullwidth">Vérifier →</button>
    </div>
  </form>

  <style>
    .collapser {
      color: black;
      margin-bottom: 1rem;
    }
  </style>

  <script>
    this.mixin('localDate')

    if (!this.eventData) {
      this.eventData = this.opts.eventData || {}
    }

    this.addDate = this.opts.addDate

    this.showDates = this.eventData.creating
    if (!this.showDates) this.eventPrefs = this.opts.eventPrefs
    this.datesGiven = []

    this.dates = [
      {
        n: 1,
        lastDate: this.eventData.from
      }
    ]

    const boop = (d, t) => new Date(`${d}T${t}`).toISOString().split('.')[0] + ' UTC'

    const parsePicks = () => this.eventPrefs
      .filter(({ picked }) => picked)
      .map(({ local, pref }) => {
        const [date, time] = local.split('T')
        const o = { date }

        if (pref) o.preference = `${100 * pref}%`

        if (time) {
          o.time = time
          o.utcTime = boop(o.date, o.time)
        } else {
          o.offset = this.offset
        }
        return o
      })

    const moreDates = () => {
      const dates = Array.isArray(this.refs.date) ? this.refs.date : [this.refs.date]
      const times = Array.isArray(this.refs.time) ? this.refs.time : [this.refs.time]
      const prefs = dates.map((a, x) => this.refs[`preference-${x + 1}`].going)
      const oy = dates
        .map((date, i) => {
          if (!date.value || !prefs[i]) return
          const o = {
            date: date.value,
            preference: `${100 * prefs[i]}%`
          }
          if (times[i].value) {
            o.time = times[i].value
            o.utcTime = boop(o.date, o.time)
          } else {
            o.offset = this.offset
          }
          return o
        })
        .filter(Boolean)

      this.datesGiven = this.eventPrefs ? [...parsePicks(), ...oy] : oy
    }

    submit(e) {
      e.preventDefault()
      e.preventUpdate = true
      this.refs.name.classList.remove('is-danger')
      this.refs.email.classList.remove('is-danger')
      this.refs.name.classList.add('is-success')
      if (this.refs.email.value) this.refs.email.classList.add('is-success')
      moreDates()

      let str = `Kyucan - ${this.refs.name.value}`
      if (this.datesGiven.length) str += (this.datesGiven.length === 1) ? ` (un moment)` : ` (${this.datesGiven.length} moments)`
      document.title = str
      this.opts.setShow(true, this.datesGiven, this.refs.name.value, this.refs.email.value)
    }

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
          lastDate: this.localDate(new Date(Date.parse(date.value) + 86400000))
        })
      }
      this.update()

      const date2 = Array.isArray(this.refs.date) ? this.refs.date.slice(-1)[0] : this.refs.date
      date2.focus()

      const time = Array.isArray(this.refs.time) ? this.refs.time.slice(-1)[0] : this.refs.time
      time.scrollIntoView({ behavior: 'smooth', block: 'nearest' })
    }

    this.firstShow = !this.showDates
    collapse() {
      this.showDates = !this.showDates
      if (this.showDates && this.firstShow) {
        this.firstShow = false
        document.querySelector('fieldset.is-hidden .radio.has-text-success').click()
      }
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

    setPreference(ev, g) {
      ev.item.pref = g
    }

    pickPref(ev) {
      ev.item.picked = ev.target.checked
    }

    invalid(e) {
      this.refs.email.classList.remove('is-danger')
      if (this.refs.email.value) this.refs.email.classList.add('is-success')
        e.target.classList.add('is-danger')
    }

    this.on('update', (a) => {
      if (a && a.loadingError) {
        this.loadingError = a.loadingError.toString()
        return
      }

      if (!this.eventData.instigator || !this.eventData.creating) {
        this.refs.name.focus()
      }
    })

    if (!this.eventData.instigator) this.on('mount', () => this.refs.name.focus())
  </script>
</vote-form>
