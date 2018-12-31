<app>
  <hero-tag />
  <router>
    <route path="/"><form-tag top="3"/></route>
    <route path="evenement"><event-form /></route>
    <route path="colophon">
      <section class="section container">
        <colophon-tag foo="boo" page="1" />
      </section>
    </route>
  </router>
  <footer-tag commithash="{commithash}"><p>Ligne numéro deux</p></footer-tag>

  <script>
    this.commithash = this.opts.commithash
  </script>
</app>
