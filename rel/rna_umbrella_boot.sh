#!/bin/sh
set -euo pipefail
IFS=$'\n\t'

/opt/app/bin/rna_umbrella ecto.create || true
/opt/app/bin/rna_umbrella ecto.migrate
/opt/app/bin/rna_umbrella foreground
