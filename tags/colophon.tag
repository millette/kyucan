<colophon-tag>
  <h3 class="title is-3">Colophon</h3>
  <h4 class="subtitle is-4">Dépendances</h4>
  <div class="columns is-multiline is-mobile">
    <div class="{colClasses}">
      <div class="card has-text-weight-bold"><pkg-tag pkg="{kyucan}" /></div>
    </div>
    <div each="{pkgs}" class="{parent.colClasses}">
      <div class="card"><pkg-tag pkg="{this}" /></div>
    </div>
  </div>

  <script>
    this.mixin("oy")
    this.mixin("routed")
    this.pkgs = this.getPkgs()
    this.colClasses =
      "column is-full-mobile is-half-tablet is-one-third-desktop is-one-quarter-fullhd"

    // poo and clean() prevent polluting the pkg objects in pkgs and kyucan
    const poo = {}
    Object.keys(this).forEach((k) => (poo[k] = undefined))
    const clean = (x) => ({ ...x, ...poo })
    this.kyucan = clean(this.self())
    this.pkgs = this.pkgs.map(clean)
  </script>
</colophon-tag>
