<colophon-tag>
  <h3 class="title is-3">Colophon</h3>
  <h4 class="subtitle is-4">Dépendances</h4>
  <div class="columns is-multiline is-mobile">
    <div
      each="{pkgs}"
      class="column is-half-mobile is-one-third-tablet is-one-quarter-desktop"
    >
      <div class="card"><pkg-tag pkg="{this}" /></div>
    </div>
  </div>

  <style>
    h3 {
      margin-top: 1em;
    }
    .notification {
      height: 100%;
    }
  </style>

  <script>
    this.mixin("oy")
    this.pkgs = this.getPkgs()

    // poo and clean() prevent polluting the pkg objects in pkgs
    const poo = {}
    Object.keys(this).forEach((k) => (poo[k] = undefined))
    const clean = (x) => ({ ...x, ...poo })
    this.pkgs = this.pkgs.map(clean)
  </script>
</colophon-tag>
