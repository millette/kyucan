<event-edit>
  <section class="section">
    <div class="container">
      <div class="columns content">
        <div class="column">
          <h2 class="title is-3">Événement créé</h2>
          <h3 class="subtitle is-5">Identifiant: {eventid}</h3>
          <clipboard-tag ref="cb" if="{voteUrl}" val="{voteUrl}" type="url" />
        </div>
        <div class="column">
          <h2 class="title is-3">Instructions</h2>
          <p>
            Partagez le lien
            <code>
              <out-link if="{voteUrl}" href="{voteUrl}"
                >{parent.voteUrl}</out-link
              >
            </code>
            avec vos invités pour leur permettre de voter.
          </p>
          <p>
            Conservez le lien précieusement, c'est la seule clé pour accéder aux
            données et l'administrateur de ce site n'a pas d'accès non plus sans
            cet URL.
          </p>
        </div>
      </div>
    </div>
  </section>

  <script>
    this.mixin("routed")

    this.on("route", (e) => {
      this.eventid = e
      const aEl = document.createElement("a")
      aEl.href = `#vote/${e}`
      // make link absolute, including schema and domain name
      this.voteUrl = aEl.href
    })
  </script>
</event-edit>
