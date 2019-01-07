<voted-tag>
  <section class="section">
    <div class="container"><p>I have voted! {eventid} {voteid}</p></div>
  </section>

  <script>
    this.on("route", (e, v) => {
      this.eventid = e
      this.voteid = v
    })
  </script>
</voted-tag>
