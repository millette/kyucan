<vote-form>
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

    <fieldset>
      <legend>Mes choix</legend>
      <virtual each="{eventPrefs}">
        <p>One...</p>
        <div class="{picked ? 'woot' : 'woot2'}">
          <label class="checkbox">
            <input type="checkbox" onchange="{pickPref}" /> {local.replace('T',
            ' à ')}
          </label>

          <div if="{picked}">
            <preference-tag set-preference="{setPreference}" pref="{pref}" />
          </div>
        </div>
      </virtual>
    </fieldset>

    <p if="{!showDates}" class="has-pointer collapser" onclick="{collapse}">
      Ajouter des dates et des heures
    </p>

    <fieldset class="{showDates ? '' : 'is-hidden'}">
      <legend onclick="{collapse}" class="has-pointer">
        Ajouter des dates et des heures
      </legend>
      <virtual each="{dates}">
        <div class="woot">
          <div class="field">
            <label class="label">Date #{n}</label>
            <div class="control">
              <input
                ref="date"
                class="input"
                type="date"
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
          <preference-tag ref="preference" />
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

  <script>
    this.eventPrefs = this.opts.eventPrefs
    this.eventData = this.opts.eventData
    this.addDate = this.opts.addDate

    this.showDates = false
    this.datesGiven = []

    this.dates = [
      {
        n: 1,
        lastDate: this.eventData.from
      }
    ]

    const makeOffset = () => {
      const xx0 = 100 * new Date().getTimezoneOffset() / 60
      const xx = `${xx0}`.padStart(4, '0')
      const s = xx0 < 0 ? '+' : '-'
      return `UTC${s}${xx}`
    }

    const offset = makeOffset()

    const boop = (d, t) => new Date(`${d}T${t}`).toISOString().split('.')[0] + ' UTC'

    const parsePicks = () => this.eventPrefs
      .filter(({ picked }) => picked)
      .map(({ local, pref }) => {
        const [date, time] = local.split('T')
        const o = {
          date,
          preference: `${100 * pref}%`
        }
        if (time) {
          o.time = time
          o.utcTime = boop(o.date, o.time)
        } else {
          o.offset = offset
        }
        return o
      })

    const parseDate = (times, date, i) => {
      if (!date.value) return

      const preferences = Array.isArray(this.refs.preference)
        ? this.refs.preference.map((x) => x.refs.preference.valueAsNumber)
        : [this.refs.preference.refs.preference.valueAsNumber]

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

      const dates = Array.isArray(this.refs.date) ? this.refs.date : [this.refs.date]
      const times = Array.isArray(this.refs.time) ? this.refs.time : [this.refs.time]
      this.datesGiven = [...parsePicks()]
      dates.forEach(parseDate.bind(this, times))

      let str = `Kyucan - ${this.name}`
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
          lastDate: date.value
        })
      }
      this.update()

      const date2 = Array.isArray(this.refs.date) ? this.refs.date.slice(-1)[0] : this.refs.date
      date2.focus()

      const time = Array.isArray(this.refs.time) ? this.refs.time.slice(-1)[0] : this.refs.time
      time.scrollIntoView({ behavior: 'smooth', block: 'nearest' })
    }

    collapse() {
      this.showDates = !this.showDates
      if (this.showDates && !this.refs.date.value) {
        this.refs.date.value = this.refs.date.min
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

    setPreference(ev) {
      ev.item.pref = ev.target.value
    }

    pickPref(ev) {
      ev.item.picked = ev.target.checked
    }

    invalid(e) {
      this.refs.email.classList.remove('is-danger')
      if (this.refs.email.value) this.refs.email.classList.add('is-success')
        e.target.classList.add('is-danger')
    }

    // this.on('mount', () => this.refs.name.focus())
  </script>
</vote-form>
