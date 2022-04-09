{ pkgs }:

pkgs.writeShellScriptBin "check-persist" ''
folders=$(cat /proc/mounts | grep subvol=/persist | awk '{ print $2 }')
findCmd="find /persist"

for folder in $folders; do
  if [ "$folder" == "/persist" ]; then
    continue
  fi
  folder="/persist''${folder/\\040/" "}"
  findCmd+=" ! -path '$folder*'"

  while [ "$folder" != "/persist" ]; do
    folder=$(dirname "$folder")
    findCmd+=" ! -path '$folder'"
  done
done

toBeDeleted=$(eval "$findCmd")

if [ "$toBeDeleted" == "" ]; then
  exit 0
fi

tempFile=$(mktemp)

echo "Unlinked files detected on persist partition. These files are not linked and should probably be deleted." > $tempFile
echo "" >> $tempFile
echo "$toBeDeleted" >> $tempFile

${pkgs.gnome.zenity}/bin/zenity --text-info \
       --width="1000" \
       --height="800" \
       --filename=$tempFile \
       --checkbox="Delete these files"

case $? in
  0)
    findCmd+=" -delete"
    eval "$findCmd"
    ;;
esac

rm $tempFile
''