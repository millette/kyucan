<event-tag>
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

  <style>
    dl {
      margin-bottom: 1em;
    }
  </style>

  <script>
    this.on("*", (c) => console.log("ON-EVENT", c, this.eventData))
    this.eventData = this.opts.event || {}
  </script>
</event-tag>
