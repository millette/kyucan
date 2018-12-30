<preference-tag>
  <div class="field">
    <div class="control" onclick="{clicky}">
      <label class="radio has-text-success">
        <input type="radio" value="1" name="{rsvp}" checked="{isyes}" /> Oui
      </label>
      <label class="radio has-text-danger">
        <input type="radio" name="{rsvp}" checked="{!isyes}" /> Non
      </label>
      <label class="radio has-text-info">
        <input type="radio" value="0.5" name="{rsvp}" /> Possiblement
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
    this.going = 1
    this.isyes = !this.opts.isno
    this.going = this.isyes ? 1 : 0

    clicky(ev) {
      this.going = parseFloat(ev.target.value) || 0
      if (this.opts.setPreference && (ev.target.type === 'radio')) this.opts.setPreference(ev, this.going)
    }
  </script>
</preference-tag>
