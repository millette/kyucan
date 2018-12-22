<form-tag>
  <section class="section">
    <div class="container">
      <form class="box" onsubmit="{submit}">
        <div class="field">
          <label class="label">Name</label>
          <div class="control">
            <input
              name="name"
              required
              class="input"
              type="text"
              placeholder="Full name or first name"
            />
          </div>
        </div>

        <div class="field">
          <label class="label">Email</label>
          <div class="control">
            <input
              name="email"
              class="input"
              type="email"
              placeholder="name@example.com"
            />
          </div>
        </div>
        <button class="button is-primary">Go</button>
      </form>
    </div>
  </section>
  <script>

    submit(e) {
      e.preventDefault()
      console.log('EEEE:', e)
      console.log('EEEE-TARGET:', e.target)
    }
  </script>
</form-tag>
