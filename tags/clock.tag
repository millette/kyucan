<clock-tag>
  <nav class="level is-mobile">
    <div class="level-item has-text-centered"><h1 class="title">{dd}</h1></div>
    <div class="level-item has-text-centered"><h1 class="title">{tt}</h1></div>
  </nav>

  <script>
    const fn0 =
      this.opts.format && this.opts.format.toLowerCase() === "gmt"
        ? "toGMTString"
        : "toISOString"
    const step = (ts) => {
      // might skip according to probability p, but only after the first step
      if (ts && Math.random() < (this.opts.p ? parseFloat(this.opts.p) : 0.8))
        return window.requestAnimationFrame(step)
      const x = new Date()[fn0]().split("T")
      this.dd = x[0]
      this.tt = x[1]
      this.update()
      window.requestAnimationFrame(step)
    }

    step()
  </script>
</clock-tag>
