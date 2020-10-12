#!/bin/sh

# logging functions
mai_log() {
	local type="$1"; shift
	printf '%s [%s] [Entrypoint]: %s\n' "$(date --rfc-2822)" "$type" "$*"
}
mai_note() {
	mai_log Note "$@"
}
mai_warn() {
	mai_log Warn "$@" >&2
}
mai_error() {
	mai_log ERROR "$@" >&2
	exit 1
}

# check to see if this file is being run or sourced from another script
_is_sourced() {
	# https://unix.stackexchange.com/a/215279
	[ "${#FUNCNAME[@]}" -ge 2 ] \
		&& [ "${FUNCNAME[0]}" = '_is_sourced' ] \
		&& [ "${FUNCNAME[1]}" = 'source' ]
}

_main() {

    if [ -f tmp/pids/server.pid ]; then
        rm tmp/pids/server.pid
    fi

    if [ "$RAILS_ENV" = '' ]; then
        export RAILS_ENV='production'    
    fi

    # Wait for DB
    tries=50
    mai_note "Wait for DB"
    while ! nc -w1 ${DB_HOST} ${DB_PORT} < /dev/null > /dev/null ; do
        mai_note "DB not ready. $tries attempts remaining. Waiting..."
        sleep 5
        tries=$((tries-1))
        if [ $tries -le "0" ]; then
            mai_error "DB not found"
        fi
    done

    #Si hay q crear la base
    bundle exec rake db:create || true
    #migrar la db
    bundle exec rake db:migrate || true
    bundle exec rake seed:migrate || true
    
    if [ "$RAILS_ENV" != 'production' ]; then
        mai_note "Construimos los assets actuales"
        # Al montar el directorio devemos asegurarnos de tener las dependencias.
        yarn install --check-files
        bin/webpack
    fi

    exec "$@"
}

# If we are sourced from elsewhere, don't perform any further actions
if ! _is_sourced; then
	_main "$@"
fi