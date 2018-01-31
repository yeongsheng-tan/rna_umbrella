source .env

MIX_ENV=${MIX_ENV:-prod}

MIX_ENV=$MIX_ENV mix release.clean --implode --no-confirm
MIX_ENV=$MIX_ENV mix do deps.get, compile, phx.digest, release --profile=rna_umbrella:$MIX_ENV
