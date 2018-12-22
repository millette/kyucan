<form-tag>
  <section class="section">
    <div class="container">
      <div class="columns">
        <div class="column">
          <form class="box" onsubmit="{submit}">
            <div class="field">
              <label class="label">Name</label>
              <div class="control">
                <input
                  ref="name"
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
                  ref="email"
                  class="input"
                  type="email"
                  placeholder="name@example.com"
                />
              </div>
            </div>
            <button class="button is-primary">Go</button>
          </form>
        </div>
        <div if="{show}" class="column">
          <article class="message is-primary">
            <div class="message-header">
              <p>Dark</p>
              <button
                onclick="{deleteMessage}"
                class="delete"
                aria-label="delete"
              ></button>
            </div>
            <div class="message-body content">
              <dl>
                <dt>Name</dt>
                <dd>{name}</dd>
              </dl>
              <virtual if="{email}">
                <dl>
                  <dt>Email</dt>
                  <dd>{email}</dd>
                </dl>
              </virtual>
            </div>
          </article>
        </div>
      </div>
    </div>
  </section>

  <script>
    this.show = true

    deleteMessage(e) {
      this.show = false
    }

    submit(e) {
      e.preventDefault()
      this.name = this.refs.name.value
      this.email = this.refs.email.value
      this.show = true
    }
  </script>
</form-tag>
