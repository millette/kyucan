<pkg-tag>
  <dl>
    <dt>Nom</dt>
    <dd>{name}</dd>

    <dt>Version</dt>
    <dd>{version}</dd>

    <dt>Description</dt>
    <dd>{description}</dd>
  </dl>

  <style>
    dl {
      margin-bottom: 1em;
    }
  </style>

  <script>
    this.name = this.opts.name
    this.version = this.opts.version
    this.description = this.opts.description
  </script>
</pkg-tag>
