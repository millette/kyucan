<event-tag class="content">
  <h2>{eventData.title}</h2>
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
  <pre>{JSON.stringify(eventPrefs, null, '  ')}</pre>

  <style>
    dl {
      margin-bottom: 1em;
    }
  </style>

  <script>
    this.eventData = this.opts.event
    this.eventVotes = this.opts.votes
    this.eventPrefs = this.opts.prefs
  </script>
</event-tag>
