<pkg-tag>
  <h4 class="title is-4">{name}</h4>
  <h5 class="subtitle is-5">v{version}</h5>
  <div class="content">
    <p>{description}</p>
    <p>
      <a
        if="{homepage}"
        target="_blank"
        rel="noopener noreferrer"
        href="{homepage}"
        >Site web</a
      >
    </p>
    <p>
      <button
        onclick="{toggleWhole}"
        type="button"
        class="button is-warning is-fullwidth"
      >
        Montrer les détails
      </button>
    </p>
  </div>
  <pre if="{showWhole}">{JSON.stringify(pkg, null, '  ')}</pre>

  <style>
    pre {
      whitespace: pre-wrap;
      color: black;
    }
  </style>

  <script>
    this.name = this.opts.name
    this.version = this.opts.version
    this.description = this.opts.description
    this.homepage = this.opts.homepage
    this.pkg = this.opts.pkg

    toggleWhole(ev) {
      const z = ev.target.closest('.column')
      if (this.showWhole) {
        z.classList.remove('is-12')
        this.showWhole = false
      } else {
        z.classList.add('is-12')
        this.showWhole = true
      }
    }
  </script>
</pkg-tag>
