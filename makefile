sync: generate-custom-modules-index
	@scripts/sync-config.sh

preview-custom-modules-index:
	@scripts/index-custom-modules.sh

generate-custom-modules-index:
	@scripts/index-custom-modules.sh > custom-modules/default.nix