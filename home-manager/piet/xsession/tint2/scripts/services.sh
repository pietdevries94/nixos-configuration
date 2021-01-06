#!/usr/bin/env nix-shell
#!nix-shell -i bash -p jq gksu

# Freely add services here. If they don't exist they will be hidden
user_services=(mailhog)
system_services=(podman-mssql-2017 podman-mssql-2019)

NL=$'\n'

function call_systemd_dbus {
	busctl call org.freedesktop.systemd1 /org/freedesktop/systemd1 \
		   org.freedesktop.systemd1.Manager "$@" --json=short
}

function unit_files {
	call_systemd_dbus ListUnitFiles "$1" | jq '.data[][] | (.[0] + " " + .[1])' -r
}

function running_units {
	call_systemd_dbus ListUnits "$1" | jq '.data[][] | (.[0] + " " + .[3])' -r
}

function get_units {
	{ running_units "--$1"; } | sort -u -k1,1 |
		awk -v unit_type="$1" '{print $0 " " unit_type}'
}

function get_filtered_units {
	units="$(get_units $1)"
	files="$(unit_files "--$1")"
	res=""

	if [ $1 == "user" ]; then
		services="${user_services[@]}"
	else
		services="${system_services[@]}"
	fi

	for n in $services; do
		name="$n.service"
		found="$(echo "$units" | grep $name)"

		if [ -n "$found" ]; then
			row="$found"
		elif echo "$files" | grep -q "$name"; then
			row="$name inactive $1"
		fi
			res="$res$row$NL"
	done
	echo "$res"
}

function select_service_and_act {
	result=$(rofi -dmenu -i -p "Services")

	selection="$(echo $result | sed -n 's/ \+/ /gp')"
	service_name=$(echo "$selection" | awk '{ print $1 }' | tr -d ' ')
	is_user="$(echo $selection | awk '{ print $3 }' )"
	status="$(echo $selection | awk '{ print $2 }' )"

	case "$is_user" in
		user*)
			user_arg="--user"
			command="systemctl $user_arg"
			;;
		system*)
			user_arg=""
			command="gksudo systemctl"
			;;
		*)
			command="systemctl"
	esac

	case "$status" in
		active*)
			action="stop"
			;;
		*)
			action="start"
	esac

	if [ -n "$action" ] && [ -n "$service_name" ]; then
		to_run="$command $action '$service_name'"
		eval "$to_run"
	fi
}

{ get_filtered_units user; get_filtered_units system; } | column -tc 1 | select_service_and_act
