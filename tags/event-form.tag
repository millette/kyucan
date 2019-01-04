<event-form>
  <section class="section">
    <div class="container">
      <div class="columns">
        <div class="column">
          <h3 class="title is-3">Événement</h3>
          <h4 class="subtitle is-5">Instructions</h4>
        </div>
        <div class="column is-narrow">
          <form class="box" onsubmit="{submit}">
            <div class="field">
              <label class="label">Titre</label>
              <div class="control">
                <input
                  class="input"
                  ref="title"
                  type="text"
                  placeholder="Titre de l'événement"
                />
              </div>
            </div>

            <div class="field">
              <label class="label">Instigateur</label>
              <div class="control">
                <input
                  class="input"
                  ref="instigator"
                  type="text"
                  placeholder="Personne ou organisme responsable"
                />
              </div>
            </div>

            <div class="field">
              <label class="label">Lieu</label>
              <div class="control">
                <input
                  class="input"
                  ref="location"
                  type="text"
                  placeholder="Montréal..."
                />
              </div>
            </div>

            <div class="field">
              <label class="label">Description</label>
              <div class="control">
                <textarea ref="description" class="textarea"></textarea>
              </div>
            </div>

            <div class="field">
              <label class="label">Page web</label>
              <div class="control">
                <input
                  class="input"
                  ref="url"
                  type="url"
                  placeholder="https://example.com/"
                />
              </div>
            </div>

            <div class="columns">
              <div class="column">
                <div class="field">
                  <label class="label">Durée</label>
                  <div class="control">
                    <input
                      onchange="{timeChange}"
                      class="input"
                      ref="duration"
                      type="time"
                      value="01:00"
                      min="00:15"
                      max="23:45"
                      step="900"
                    />
                  </div>
                </div>
              </div>

              <div class="column">
                <div class="field">
                  <label class="label">Premier jour</label>
                  <div class="control">
                    <input
                      required
                      ref="from"
                      min="{today}"
                      value="{today}"
                      class="input"
                      type="date"
                    />
                  </div>
                </div>
              </div>
              <div class="column">
                <div class="field">
                  <label class="label">Dernier jour</label>
                  <div class="control">
                    <input
                      required
                      min="{today}"
                      ref="until"
                      class="input"
                      type="date"
                    />
                  </div>
                </div>
              </div>
            </div>

            <div class="control">
              <button class="content button is-primary is-fullwidth">
                2<sup>e</sup>&nbsp;étape →
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </section>
  <script>
    this.mixin("store")
    this.mixin('localDate')
    this.mixin("routed")
    this.mixin("uniqueId")
    this.today = this.localDate()

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

    this.initVal = {
      creating: true,
      offset: this.offset,
      _id: this.uniqueId()
    }

    submit(ev) {
      ev.preventDefault()

      const vals = { ...this.initVal }
      let r

      for (r in this.refs) {
        vals[r] = this.refs[r].value
      }

      if (vals.from && vals.until && (vals.from > vals.until)) {
        const tmp = vals.until
        vals.until = vals.from
        vals.from = tmp
      }

      if (vals.duration) {
        const [a, b] = vals.duration.split(':')
        vals.duration = parseInt(a, 10) * 60 + parseInt(b, 10)
      }

      if (!vals.step) vals.step = 900

      this.storeSet('event', vals)
      window.location.hash = `#vote/${vals._id}`
    }
    this.on('mount', () => this.refs.title.focus())
  </script>
</event-form>
