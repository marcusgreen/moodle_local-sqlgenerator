set -e

# Re-run the data export from ss_503.sh (without SchemaSpy) and check that no
# site host name is left in the data pages. The hosts checked are the ones
# export_to_html.php reports replacing, plus any given as arguments, e.g.
#   sh check_export_503.sh 192.168.0.235
# Credentials come from schemaspy.properties, which is not committed.
cd "$(dirname "$0")"
prop() { sed -n "s/^schemaspy\.$1=//p" schemaspy.properties; }
log=$(php ../export_to_html.php -u "$(prop u)" -p "$(prop p)" -d mdl53er \
    -c schemaspy.properties --prefix=mdl_)
echo "$log" | grep -v '^Exported\|^  -> Updated'

data_dir=$(echo "$log" | sed -n 's/^Data output dir: //p')
[ -d "$data_dir" ] || { echo "Data output dir not found: $data_dir"; exit 1; }

hosts=$(echo "$log" | sed -n 's/^Replacing site host name(s) \(.*\) with .*/\1/p' | tr -d ',')
status=0
for host in $hosts "$@"; do
    count=$(grep -roiF "$host" "$data_dir" | wc -l)
    echo "$host: $count left in $data_dir"
    [ "$count" -eq 0 ] || status=1
done
[ -n "$hosts$*" ] || { echo "No host checked"; status=1; }
exit $status
