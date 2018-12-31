<footer-tag>
  <section class="footer">
    <div class="container has-text-centered">
      <p class="has-text-success">
        Je suis le footer, hear me roar!
        <a href="https://github.com/millette/kyucan/tree/{commithash}"
          >sources</a
        >
      </p>
      <yield />
    </div>
  </section>

  <script>
    this.commithash = this.opts.commithash
  </script>
</footer-tag>
