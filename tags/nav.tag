<nav-tag>
  <nav
    id="mainnav"
    class="navbar is-info"
    role="navigation"
    aria-label="main navigation"
  >
    <div class="container">
      <div class="navbar-brand">
        <a href="#" class="navbar-item">Kyucan</a>
        <a href="#colophon" class="navbar-item">Colophon</a>
        <a
          onclick="{click}"
          role="button"
          class="navbar-burger burger"
          aria-label="menu"
          aria-expanded="false"
        >
          <span aria-hidden="true"></span> <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
        </a>
      </div>

      <div class="navbar-menu">
        <div class="navbar-start">
          <a href="#evenement" class="navbar-item">Événement</a>
          <a href="#vote" class="navbar-item">Vote</a>
        </div>
      </div>
    </div>
  </nav>

  <script>
    this.on('mount', () => {
      this.el = document.querySelector('#mainnav .navbar-menu')
    })

    click(ev) {
      ev.target.classList.toggle('is-active')
      this.el.classList.toggle('is-active')
      ev.target.attributes['aria-expanded'].value = (ev.target.attributes['aria-expanded'].value === 'false') ? 'true' : 'false'
    }
  </script>
</nav-tag>
