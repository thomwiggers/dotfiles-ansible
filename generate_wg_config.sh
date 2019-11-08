if [ "$2" = "" ]; then
    echo "Usage: $0 <host> <ip-postfix>"
    exit 1
fi

host="$1"
ippfx="$2"

client_ipv4="10.20.0.$ippfx"
client_ipv6="2a01:4f8:231:3ac7:1337:1000::$ippfx/124"

if grep -B4 "$client_ipv4" host_vars/*/vars group_vars/vpn/vars; then
    echo "IP already registered!"
    exit 1
fi

if ! grep "$host" hosts > /dev/null; then
    echo "Host not found"
    exit 1
fi

echo "Host: $host"
echo "ipv4: $client_ipv4"
echo "ipv6: $client_ipv6"

server_public="UWLNqjOTcKPpR500MMRpCeAPIOgZlLrhkP9XKWp3HAo="
private_key="$(wg genkey)"
public_key="$(builtin echo $private_key | wg pubkey)"
psk="$(wg genpsk)"

allowed_ips="10.20.0.0/24, 2a01:4f8:231:3ac7:1337:1000::/96"

qrencode -t ansiutf8 <<EOF
[Interface]
Address = $client_ipv4
PrivateKey = $private_key

[Peer]
PublicKey = $server_public
PresharedKey = $psk
AllowedIPs = $allowed_ips
Endpoint = archeron.rded.nl:51820
PersistentKeepalive = 2500
EOF

tee clients.txt <<EOF
public_key: "$public_key"
preshared_key: "$psk"
EOF

cat <<EOF >> host_vars/$host/vars

# Wireguard
wireguard_public_key: "$public_key"
wireguard_private_key: "{{ ${host}_wireguard_private_key }}"
wireguard_preshared_key: "{{ ${host}_wireguard_preshared_key }}"
wireguard_client_ip: "$client_ipv4"
wireguard_client_ipv6: "$client_ipv6"
EOF

if [ -f "host_vars/$host/vault" ]; then
    vault="$(ansible-vault view host_vars/$host/vault)"
else
    vault="---"
fi
vault=$(cat <<EOF
$vault

# Wireguard
${host}_wireguard_private_key: "$private_key"
${host}_wireguard_preshared_key: "$preshared_key"
EOF
)

echo "$vault" | ansible-vault encrypt --output "host_vars/$host/vault" -
