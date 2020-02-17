#!/bin/sh

# We could use dirname of dirname, but some feel safer with sed.
# This assumes that this script lives in $WHATEVER/util/
THERE="`echo $0 | sed -e 's|/[^/]*/[^/]*$||'`"

if [ "${OPENSSL_ENGINES}" = "" ] && [ -d "${THERE}/engines" ]; then
    OPENSSL_ENGINES="${THERE}/engines"; export OPENSSL_ENGINES
fi
if [ "${OPENSSL_MODULES}" = "" ] && [ -d "${THERE}/providers" ]; then
    OPENSSL_MODULES="${THERE}/providers"; export OPENSSL_MODULES
fi

if [ -n "$EXE_SHELL" ]; then
    exec "${EXE_SHELL}" "$@"
elif [ -x "${THERE}/util/shlib_wrap.sh" ]; then
    exec "${THERE}/util/shlib_wrap.sh" "$@"
else
    exec "$@"                   # hope for the best...
fi
