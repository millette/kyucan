<app>
  <nav-tag />
  <router store="{store}">
    <route path="/"><home-tag navid="0"/></route>
    <route path="colophon">
      <section class="section container"><colophon-tag navid="1" /></section>
    </route>
    <route path="evenement"> <event-form navid="2" /> </route>
    <route path="vote/*"> <form-tag top="3" navid="3" /> </route>
    <route path="vote/*/*"> <voted-tag navid="3" /> </route>
  </router>
  <footer-tag commithash="{commithash}"><p>Ligne numéro deux</p></footer-tag>

  <script>
    this.commithash = this.opts.commithash
    this.store = this.opts.store
    //     <route path="evenement/*"> <event-form navid="2" /> </route>
  </script>
</app>
