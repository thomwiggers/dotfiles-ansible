server_public="UWLNqjOTcKPpR500MMRpCeAPIOgZlLrhkP9XKWp3HAo="
private_key="$(wg genkey)"
public_key="$(builtin echo $private_key | wg pubkey)"
psk="$(wg genpsk)"

client_ip="10.20.0.201"
client_ipv6="2a01:4f8:231:3ac7:1337:1000::201/124"
allowed_ips="10.20.0.0/24, 2a01:4f8:231:3ac7:1337:1000::201/96"

qrencode -t ansiutf8 <<EOF
[Interface]
Address = $client_ip
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
