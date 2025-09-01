#! /bin/bash

set -euo pipefail


cd /src/content

find . -type f -name "*.md" | while read -r file; do
  # Récupération de la date du dernier commit sur le fichier
  LASTMOD=$(git log -1 --format="%ad" --date=iso-strict -- "$file")


  # Si aucune date trouvée (par exemple fichier non committé), on saute
  if [ -z "$LASTMOD" ]; then
    echo "Skip (no git history): $file"
    continue
  fi

  echo "Updating $file with lastmod: $LASTMOD"

  # Vérifie si 'lastmod:' existe déjà
    # Modifier la valeur existante
    sed -i -E "s/^(date: ).*/\1$LASTMOD/" "$file"
done
