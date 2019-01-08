<instructions-tag class="content">
  <h3>Instructions <small if="{creating}">(suite)</small></h3>
  <p if="{creating}">
    Ajouter des dates et des heures pour compléter la création d'un événement.
  </p>

  <p>
    Inscrivez votre <code>nom</code> pour qu'on vous reconnaisse ainsi que votre
    <code>email</code> si vous désirez obtenir des notifications.
  </p>
  <p>
    Ensuite, ajoutez les <code>dates</code> et les <code>heures</code> qui vous
    conviennent ainsi qu'une <code>préférence</code> pour ces moments.
  </p>
  <p>
    Finalement, on calculera les <code>scores</code> pour tous les moments
    soumis par les participants intéressés à cet événement.
  </p>

  <script>
    this.creating = this.opts.creating
  </script>
</instructions-tag>
