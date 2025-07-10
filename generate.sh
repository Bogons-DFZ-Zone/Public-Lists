#!/bin/bash

INPUT="bogons.csv"
YAML_OUT="bogon-asns.yaml"
BLOCKLIST_OUT="blocklist-for-pathvector.txt"

# Generate bogon-asns.yaml
echo "bogon-asns:" > "$YAML_OUT"

# Prepare temporary files for blocklist
ASN_TMP=$(mktemp)
IPV4_TMP=$(mktemp)
IPV6_TMP=$(mktemp)

awk -F',' '
    BEGIN {
        FPAT = "([^,]+)|(\"[^\"]+\")"
    }
    NR > 1 {
        # Strip quotes
        gsub(/^"|"$/, "", $1)
        gsub(/^"|"$/, "", $2)

        if ($1 == "asn") {
            print "  - " $2 >> "'"$YAML_OUT"'"
            print $2 >> "'"$ASN_TMP"'"
        } else if ($1 == "ipv4") {
            print $2 >> "'"$IPV4_TMP"'"
        } else if ($1 == "ipv6") {
            print $2 >> "'"$IPV6_TMP"'"
        }
    }
' "$INPUT"

# Assemble blocklist-for-pathvector.txt
{
    echo "# ASNs"
    cat "$ASN_TMP"
    echo
    echo "# IPv4"
    cat "$IPV4_TMP"
    echo
    echo "# IPv6"
    cat "$IPV6_TMP"
} > "$BLOCKLIST_OUT"

# Cleanup
rm -f "$ASN_TMP" "$IPV4_TMP" "$IPV6_TMP"

echo "Generated:"
echo "  - $YAML_OUT"
echo "  - $BLOCKLIST_OUT"
