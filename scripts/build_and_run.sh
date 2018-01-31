source ./scripts/build.sh

echo "Kill existing rna_spike erlang processes"
pgrep -fl rel/rna_spike | cut -d" " -f1 | xargs kill -9

echo "Start application as foreground"
REPLACE_OS_VARS=true _build/$MIX_ENV/rel/rna_spike/bin/rna_spike foreground

pgrep -fl rel/rna_spike | cut -d" " -f1 | xargs kill -9
