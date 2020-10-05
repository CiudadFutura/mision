#!/bin/bash
set -eo pipefail
shopt -s nullglob

# logging functions
mai_log() {
	local type="$1"; shift
	printf '%s [%s] [Entrypoint]: %s\n' "$(date --rfc-3339=seconds)" "$type" "$*"
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

    if [ "$RAILS_ENV" = '' ]; then
        export RAILS_ENV='production'
    fi

    if [ "$RAILS_ENV" = 'production' ]; then
        if [ ! -z "${DB_NAME}" ]; then
            sed -i "s/database: my_db_name/database: ${DB_NAME}/g" config/database.yml
            mai_note DB_NAME "set"
        else
            mai_note DB_NAME default
        fi

        if [ ! -z "${DB_USER}" ]; then
            sed -i "s/username: root/username: ${DB_USER}/g" config/database.yml
            mai_note DB_USER "set"
        else
            mai_note DB_USER default
        fi

        if [ ! -z "${DB_PASS}" ]; then
            sed -i "s/password: my_password/password: ${DB_PASS}/g" config/database.yml
            mai_note DB_PASS "set"
        else
            mai_note DB_PASS default
        fi

        if [ ! -z "${DB_HOST}" ]; then
            sed -i "s/host: 127.0.0.1/host: ${DB_HOST}/g" config/database.yml
            mai_note DB_HOST "set"
        else
            mai_note DB_HOST default
        fi

        if [ ! -z "${DB_PORT}" ]; then
            sed -i "s/port: 3306/port: ${DB_PORT}/g" config/database.yml
            mai_note DB_PORT "set"
        else
            mai_note DB_PORT default
        fi
        sed -i "s/socket: \/var\/run\/mysqld\/mysqld.sock/#socket: \/var\/run\/mysqld\/mysqld.sock/g" config/database.yml
    fi

    #Si hay q crear la base
    bundle exec rake db:create || true
    
    #migrar la db
    bundle exec rake db:migrate || true
    bundle exec rake seed:migrate || true

    exec "$@"
}

# If we are sourced from elsewhere, don't perform any further actions
if ! _is_sourced; then
	_main "$@"
fi