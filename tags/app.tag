<app>
  <section class='section'>
    <div class='container'>
      <h3 class="title is-5">{ message }</h3>
      <div class='content'>
        <ul>
          <li each={ techs }>{ name }</li>
        </ul>
      </div>
    </div>
  </section>

  <footer-tag>
    <p>Ligne numéro deux</p>
  </footer-tag>

  <script>
    this.message = 'Hello, Riot!'
    this.techs = [
      { name: 'HTML' },
      { name: 'JavaScript' },
      { name: 'CSS' }
    ]
  </script>
</app>
