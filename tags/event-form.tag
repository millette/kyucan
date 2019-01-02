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
                  ref="website"
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
                      ref="firstday"
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
                      min="{today}"
                      ref="lastday"
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
    // this.mixin("event")
    this.mixin('localDate')
    this.mixin("routed")
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

    submit(ev) {
      ev.preventDefault()

      const vals = { offset: this.offset }
      let r
      for (r in this.refs) {
        vals[r] = this.refs[r].value
      }
      if (vals.firstday && vals.lastday && (vals.firstday > vals.lastday)) {
        const tmp = vals.lastday
        vals.lastday = vals.firstday
        vals.firstday = tmp
      }

      console.log(vals)
    }
  </script>
</event-form>
