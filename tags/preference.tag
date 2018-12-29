<preference-tag>
  <div class="field">
    <label class="label level is-mobile">
      <small class="level-item">au besoin</small>
      <div class="level-item">Préférence</div>
      <small class="level-item">oui</small>
    </label>
    <div class="control">
      <input
        ref="{ref}"
        onchange="{setPreference}"
        class="input"
        type="range"
        value="{pref}"
        min="0.5"
        max="1"
        step="0.05"
      />
    </div>
  </div>

  <script>
    this.ref = this.opts.ref
    this.setPreference = this.opts.setPreference
    this.pref = "pref" in this.opts ? this.opts.pref : 1
  </script>
</preference-tag>
