# ----------
# Basic configuration
# ----------
BF_DIR=".blackfire"
BF_BIN_DIR="$BF_DIR/bin"
BF_AGENT_RUN_DIR="$BF_DIR/var/run"
BF_AGENT_SOCKET_FILE="/app/${BF_AGENT_RUN_DIR}/agent.sock"
BF_AGENT_LOG_DIR="$BF_DIR/var/log"
BF_AGENT_CONFIG_FILE="$BF_DIR/etc/agent"
BF_CLIENT_CONFIG_FILE=".blackfire.ini"

BF_BUILD_INSTALL_DIR="$BUILD_DIR/$BF_DIR"
BF_BUILD_BIN_DIR="$BUILD_DIR/$BF_BIN_DIR"
BF_BUILD_AGENT_RUN_DIR="$BUILD_DIR/$BF_AGENT_RUN_DIR"
BF_BUILD_AGENT_CONFIG_FILE="$BUILD_DIR/$BF_AGENT_CONFIG_FILE"
BF_BUILD_CLIENT_CONFIG_FILE="$BUILD_DIR/$BF_CLIENT_CONFIG_FILE"
BF_BUILD_LOG_DIR="$BUILD_DIR/$BF_AGENT_LOG_DIR"
BF_CACHE_DIR="$CACHE_DIR/$BF_DIR"

mkdir -p "$BF_BUILD_INSTALL_DIR" "$BF_BUILD_BIN_DIR" "$BF_BUILD_AGENT_RUN_DIR" "$BF_BUILD_LOG_DIR" "$BF_CACHE_DIR"

# ----------
# Provisioning credentials and settings from config vars.
# Some variables are mandatory and need to be checked.
# ----------
for mandatoryVar in "BLACKFIRE_SERVER_ID" "BLACKFIRE_SERVER_TOKEN" "BLACKFIRE_CLIENT_ID" "BLACKFIRE_CLIENT_TOKEN"
do
  if [ ! -f "$ENV_DIR/$mandatoryVar" ] ; then
    error "$mandatoryVar config variable must be defined!"
  else
    # Assign the config var properly.
    declare $mandatoryVar=$(cat "$ENV_DIR/$mandatoryVar")
  fi
done

# ----------
# Optional config vars
# ----------
BLACKFIRE_LOG_LEVEL="1"
BLACKFIRE_COLLECTOR="https://blackfire.io"
BLACKFIRE_AGENT_SOCKET=unix://${BF_AGENT_SOCKET_FILE}
# Assign new values when applicable (config vars set up in Heroku dashboard).
[ -f "$ENV_DIR/BLACKFIRE_LOG_LEVEL" ] && BLACKFIRE_LOG_LEVEL=$(cat $ENV_DIR/BLACKFIRE_LOG_LEVEL)
[ -f "$ENV_DIR/BLACKFIRE_COLLECTOR" ] && BLACKFIRE_COLLECTOR=$(cat $ENV_DIR/BLACKFIRE_COLLECTOR)
[ -f "$ENV_DIR/BLACKFIRE_AGENT_SOCKET" ] && BLACKFIRE_AGENT_SOCKET=$(cat $ENV_DIR/BLACKFIRE_AGENT_SOCKET)
