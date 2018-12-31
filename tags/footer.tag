<footer-tag>
  <section class="footer">
    <div class="container has-text-centered">
      <p class="has-text-success">
        Je suis le footer, hear me roar!
        <out-link href="https://github.com/millette/kyucan/tree/{commithash}">
          <span class="link">sources - hash #{parent.commithash}</span>
        </out-link>
      </p>
      <yield />
    </div>
  </section>

  <style>
    .link {
      color: white !important;
    }

    .link:hover {
      color: yellow !important;
    }
  </style>

  <script>
    this.commithash = this.opts.commithash
  </script>
</footer-tag>
