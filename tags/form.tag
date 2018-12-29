<form-tag>
  <section class="section container">
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
  </section>

  <style>
    .woot,
    .woot2 {
      margin-bottom: 0.5rem;
      padding: 0.25rem;
    }

    .woot:nth-child(odd) * {
      background: #eef;
    }

    .woot:nth-child(even) * {
      background: #fee;
    }

    fieldset {
      overflow-y: scroll;
      max-height: 25rem;
    }

    label.checkbox {
      color: black;
      display: block;
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
     this.mixin("routed")
     this.show = false
     // this.showDates = false
     this.datesGiven = []

     /*
     this.dates = [
       {
         n: 1,
         lastDate: this.eventData.from
       }
     ]
     */

     setShow(show, datesGiven, name, email) {
        this.show = show
        if (datesGiven) this.datesGiven = datesGiven
        if (name) this.name = name
        if (email) this.email = email
        this.update()
        if (show) document.getElementById('choices').scrollIntoView({ behavior: 'smooth' })
     }

     /*
     setPreference(ev) {
       ev.item.pref = ev.target.value
     }

     pickPref(ev) {
       ev.item.picked = ev.target.checked
     }
     */

     /*
     collapse() {
       this.showDates = !this.showDates
       if (this.showDates && !this.refs.date.value) {
         this.refs.date.value = this.refs.date.min
       }
     }
     */

     deleteMessage() { this.show = false }

     /*
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
     */

     /*
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
     */

     /*
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
     */

     /*
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
     */

     /*
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
       this.datesGiven = [...parsePicks()]
       dates.forEach(parseDate.bind(this, times))

       let str = `Kyucan - ${this.name}`
       if (this.datesGiven.length) str += (this.datesGiven.length === 1) ? ` (un moment)` : ` (${this.datesGiven.length} moments)`
       document.title = str
       this.show = true
       this.update()
       document.getElementById('choices').scrollIntoView({ behavior: 'smooth' })
     }
     */
  </script>
</form-tag>
