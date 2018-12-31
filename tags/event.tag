<event-tag>
  <h3 class="subtitle is-4">{eventData.title}</h3>
  <div class="content">
    <p>{eventData.description}</p>
    <dl>
      <dt>Instigateur</dt>
      <dd>{eventData.instigator}</dd>

      <dt>Durée</dt>
      <dd>{eventData.duration / 60}h</dd>

      <dt>Lieu</dt>
      <dd>{eventData.location}</dd>

      <dt>Entre</dt>
      <dd>{eventData.from}</dd>
      <dd>{eventData.until}</dd>
    </dl>
  </div>

  <style>
    dl {
      margin-bottom: 1em;
    }
  </style>

  <script>
    this.eventData = this.opts.event
  </script>
</event-tag>
