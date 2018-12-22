<colophon-tag class="content">
  <h3>Colophon</h3>
  <virtual each="{json}">
    <pkg-tag name="{name}" version="{version}" description="{description}" />
  </virtual>

  <style>
    h3 {
      margin-top: 1em;
    }
  </style>

  <script>
    this.mixin("oy")
    console.log("oy:", this.oy)
    this.json = this.getPkgs()
  </script>
</colophon-tag>
