<event-tag>
  <article if="{loadingError}" class="message is-danger">
    <div class="message-header"><p>Erreur de chargement</p></div>
    <div class="message-body">
      <p>Vérifiez l'URL, cet événement ne semble pas exister.</p>
      <p>{loadingError}</p>
    </div>
  </article>

  <article if="{loading && !loadingError}" class="message is-warning">
    <div class="message-header"><p>Chargement</p></div>
    <div class="message-body">
      <p>Veuillez patienter svp...</p>
      <span class="button is-warning is-loading is-fullwidth"></span>
    </div>
  </article>

  <virtual if="{!loading && !loadingError}">
    <h3 class="subtitle is-4">{eventData.title}</h3>
    <div class="content">
      <p>{eventData.description}</p>
      <dl>
        <dt if="{eventData.instigator}">Instigateur</dt>
        <dd if="{eventData.instigator}">{eventData.instigator}</dd>

        <dt if="{eventData.duration}">Durée</dt>
        <dd if="{eventData.duration}">{eventData.duration / 60}h</dd>

        <dt if="{eventData.location}">Lieu</dt>
        <dd if="{eventData.location}">{eventData.location}</dd>

        <dt if="{eventData.url}">Site web</dt>
        <dd if="{eventData.url}">
          <a href="{eventData.url}">{eventData.url}</a>
        </dd>

        <dt if="{(eventData.from && eventData.until)}">Entre</dt>
        <dd if="{eventData.from}">{eventData.from}</dd>
        <dd if="{eventData.until}">{eventData.until}</dd>
        <dd if="{eventData.offset}">{eventData.offset}</dd>
      </dl>
    </div>
  </virtual>

  <style>
    dl {
      margin-bottom: 1em;
    }
  </style>

  <script>
    this.loading = !this.opts.event
    this.eventData = this.opts.event

    this.on("update", (a) => {
      this.loading = !this.eventData
      if (a && a.loadingError) {
        this.loadingError = a.loadingError.toString()
      }
    })
  </script>
</event-tag>
