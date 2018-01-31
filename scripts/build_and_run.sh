source ./scripts/build.sh

echo "Kill existing rna_umbrella erlang processes"
pgrep -fl rel/rna_umbrella | cut -d" " -f1 | xargs kill -9

echo "Start application as foreground"
REPLACE_OS_VARS=true _build/$MIX_ENV/rel/rna_umbrella/bin/rna_umbrella foreground

pgrep -fl rel/rna_umbrella | cut -d" " -f1 | xargs kill -9
