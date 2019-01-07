<event-edit>
  <section class="section">
    <div class="container"><p>Événement créé: {eventid}</p></div>
  </section>

  <script>
    this.mixin("routed")
    this.on("route", (e) => {
      this.eventid = e
    })
  </script>
</event-edit>
