<event-tag class="content">
  <h2>{title}</h2>
  <p>{description}</p>
  <dl>
    <virtual each="{data}">
      <dt>{dt}</dt>
      <dd>{dd}</dd>
    </virtual>
  </dl>

  <style>
    dl {
      margin-bottom: 1em;
    }
  </style>

  <script>
    this.title = this.opts.title || "Meeting de préparation XYZ"
    this.description = this.opts.description || "Description de l'événement..."
    this.data = [
      {
        dt: "Instigateur",
        dd: this.opts.instigateur || "Robin",
      },
      {
        dt: "Durée",
        dd: `${(this.opts.duration || 120) / 60}h`,
      },
      {
        dt: "Lieu",
        dd: this.opts.location || "Montréal...",
      },
    ]
  </script>
</event-tag>
