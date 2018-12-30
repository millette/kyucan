<preference-tag>
  <div class="field">
    <div class="control" onclick="{clicky}" ref="{ref}">
      <label class="radio has-text-success">
        <input type="radio" value="1" name="{rsvp}" checked /> Going
      </label>
      <label class="radio has-text-danger">
        <input type="radio" name="{rsvp}" /> Not going
      </label>
      <label class="radio has-text-info">
        <input type="radio" value="0.5" name="{rsvp}" /> Maybe
      </label>
    </div>
  </div>

  <style>
    .field {
      margin-bottom: 1rem;
    }
  </style>

  <script>
    this.rsvp = `bobo-${this._riot_id}`
    this.ref = this.opts.ref
    this.going = 1

    clicky(ev) {
      this.going = parseFloat(ev.target.value) || 0
      if (!this.ref && (ev.target.type === 'radio')) this.opts.setPreference(ev, this.going)
    }
  </script>
</preference-tag>
