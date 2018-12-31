<nav-tag>
  <aside class="menu is-pulled-right">
    <ul class="menu-list" onclick="{click}">
      <li><a href="#">Accueil</a></li>
      <li><a href="#evenement">Événement</a></li>
      <li><a href="#colophon">Colophon</a></li>
    </ul>
  </aside>

  <script>
    this.on('mount', () => {
      const x = document.querySelectorAll(
        ".menu.is-pulled-right > .menu-list > li > a",
      )
      switch (window.location.hash) {
        case '':
        case '#':
          x[0].classList.add("is-active")
          break

        case '#evenement':
          x[1].classList.add("is-active")
          break

        case '#colophon':
          x[2].classList.add("is-active")
          break
      }
    })

    click(ev) {
      document.querySelector(".menu.is-pulled-right > .menu-list > li > a.is-active").classList.remove("is-active")
      ev.target.classList.add("is-active")
    }
  </script>
</nav-tag>
