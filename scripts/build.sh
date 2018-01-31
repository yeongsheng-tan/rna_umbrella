source .env

MIX_ENV=${MIX_ENV:-prod}

MIX_ENV=$MIX_ENV mix release.clean --implode --no-confirm
MIX_ENV=$MIX_ENV mix do deps.get, compile, phoenix.digest, release --profile=rna_spike:$MIX_ENV
