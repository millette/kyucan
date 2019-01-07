<voted-tag>
  <section class="section">
    <div class="container">
      <p>Voté sur l'événement {eventid} ({voteid})</p>
    </div>
  </section>

  <script>
    this.mixin("routed")
    this.on("route", (e, v) => {
      this.eventid = e
      this.voteid = v
    })
  </script>
</voted-tag>
