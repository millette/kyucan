<footer-tag>
  <section class="footer">
    <div class="container has-text-centered has-text-success">
      <p>
        &copy; 2018-2019
        <out-link href="http://robin.millette.info/"> Robin Millette </out-link>
      </p>
      <p>
        <out-link href="https://github.com/millette/kyucan/tree/{commithash}">
          Kyucan - hash #{parent.commithash}
        </out-link>
      </p>
      <p>License AGPLv3</p>
    </div>
  </section>

  <script>
    this.commithash = this.opts.commithash
  </script>
</footer-tag>
