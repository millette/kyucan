<colophon-tag>
  <h3 class="title is-3">Colophon</h3>
  <h4 class="subtitle is-4">Dépendances</h4>

  <div class="columns is-multiline is-mobile">
    <div
      each="{pkgs}"
      class="column is-half-mobile is-one-third-tablet is-one-quarter-desktop"
    >
      <div class="notification is-info">
        <pkg-tag
          name="{name}"
          version="{version}"
          description="{description}"
          homepage="{homepage}"
          pkg="{this}"
        />
      </div>
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
    console.log("oy:", this.oy)
    this.pkgs = this.getPkgs()
  </script>
</colophon-tag>
