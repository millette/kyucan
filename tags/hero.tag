<hero-tag>
  <section class="hero is-primary is-bold">
    <div class="hero-body">
      <div class="container">
        <aside class="menu is-pulled-right">
          <ul class="menu-list" onclick="{click}">
            <li><a href="#">Accueil</a></li>
            <li><a href="#evenement">Événement</a></li>
            <li><a href="#colophon">Colophon</a></li>
          </ul>
        </aside>
        <h1 class="title">Kyucan</h1>
        <h2 class="subtitle">Qui, où, quand? Telle est la question</h2>
      </div>
    </div>
  </section>

  <script>
    this.on('mount', () => {
      this.x = document.querySelectorAll(
        ".menu.is-pulled-right > .menu-list > li > a",
      )
    })

    click(ev) {
      console.log('EV:', ev)
      this.x.forEach((y) => y.classList.remove("is-active"))
      ev.target.classList.add("is-active")
    }
  </script>
</hero-tag>
