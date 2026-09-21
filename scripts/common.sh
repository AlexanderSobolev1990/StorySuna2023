#!/usr/bin/env bash

need_cmd() {
	local cmd="$1"

	if ! command -v "$cmd" >/dev/null 2>&1; then
		printf 'Missing required command: %s\n' "$cmd" >&2
		exit 127
	fi
}

clean_dir() {
	local dir="$1"

	if [[ -z "$dir" || "$dir" == "/" ]]; then
		printf 'Refusing to remove unsafe directory: %s\n' "$dir" >&2
		exit 1
	fi

	rm -rf "$dir"
	mkdir -p "$dir"
}

clean_latex_job() {
	local dir="$1"
	local job="$2"

	rm -f "$dir"/"$job".{aux,bbl,bcf,blg,fls,fdb_latexmk,idx,ilg,ind,log,out,pdf,run.xml,synctex.gz,toc,xdv}
	rm -f "$dir"/"$job"-*.{idx,ilg,ind}
}
