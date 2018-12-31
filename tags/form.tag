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
    this.mixin("event")
    this.show = false
    this.datesGiven = []

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
