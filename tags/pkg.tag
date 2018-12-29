<pkg-tag>
  <div class="card-header">
    <h4 class="card-header-title is-uppercase">{pkg.name}</h4>
    <h5 class="card-header-title">v{pkg.version}</h5>
  </div>

  <div class="card-content">
    <p>{pkg.description}</p>
    <div class="tags">
      <span each="{keywords}" class="tag is-light is-rounded">{word}</span>
    </div>
  </div>

  <footer class="card-footer">
    <a
      class="card-footer-item"
      if="{pkg.homepage}"
      target="_blank"
      rel="noopener noreferrer"
      href="{pkg.homepage}"
      >Site web</a
    >
    <p
      class="card-footer-item has-pointer"
      onclick="{toggleWhole}"
      class="card-footer-item"
    >
      {showWhole ? 'Cacher les détails' : 'Montrer les détails'}
    </p>
  </footer>
  <pre if="{showWhole}">{JSON.stringify(pkg, null, '  ')}</pre>

  <style>
    pre {
      whitespace: pre-wrap;
      font-weight: normal;
    }
    .card-header-title,
    .card-footer-item,
    .card-content {
      color: black;
    }
    .tags {
      margin-top: 1rem;
    }
  </style>

  <script>
    this.pkg = this.opts.pkg
    this.keywords = this.opts.pkg.keywords && this.opts.pkg.keywords.slice(0, 6).map((word) => ({ word }))
    toggleWhole(ev) {
      ev.preventDefault()
      const z = ev.target.closest('.column')
      if (this.showWhole) {
        z.classList.remove('is-full')
        this.showWhole = false
      } else {
        z.classList.add('is-full')
        this.showWhole = true
      }
    }
  </script>
</pkg-tag>
