function nget
    nlogin >/dev/null
    curl -k1 -H "X-Cookie: token=$NESSUS_TOKEN" "https://"(hostname -f)":8834/$argv[1]" 2>/dev/null
end
