<footer-tag>
  <section class="footer">
    <div class="container has-text-centered">
      <p class="has-text-success">
        Je suis le footer, hear me roar!
        <out-link href="https://github.com/millette/kyucan/tree/{commithash}">
          sources - hash #{parent.commithash}
        </out-link>
      </p>
      <yield />
    </div>
  </section>

  <script>
    this.commithash = this.opts.commithash
  </script>
</footer-tag>
