<clipboard-tag>
  <p class="notification is-danger" if="{!val}">
    Attribut <code>val</code> est vide.
  </p>
  <div if="{val}" class="field" onclick="{copyit}">
    <label class="label">Cliquez pour copier vers le <i>clipboard</i></label>
    <p class="control has-icons-right">
      <input
        type="{type}"
        class="input {inputClass}"
        readonly
        ref="cb"
        value="{val}"
      />
      <i if="{wrk}" class="help {inputClass}">{wrk}</i>
      <b class="icon is-right"> {icon} </b>
    </p>
  </div>

  <style>
    .field {
      background: white;
      padding: 0.5rem;
    }

    .field,
    .field * {
      cursor: copy;
    }
  </style>

  <script>
    this.type = this.opts.type || 'text'
    this.inputClass = 'is-info'
    this.val = this.opts.val

    this.on('bebaboop', () => this.refs.cb && this.refs.cb.click())

    copyit(ev) {
      ev.preventDefault()
      try {
        // shouldn't happen with above template
        if (!this.opts.val) throw new Error('Nothing to copy; set val attribute.')
        this.refs.cb.select()
        if (!document.execCommand('copy')) throw new Error('Copying text command was unsuccessful')
        this.update({ wrk: 'Copié au clipboard', icon: '✓', inputClass: 'is-success' })
      } catch (err) {
        this.update({ wrk: err.toString(), icon: 'x', inputClass: 'is-danger' })
      }
      this.refs.cb.blur() // unselects the text
    }
  </script>
</clipboard-tag>
