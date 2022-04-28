function nlogout
    if test -z "$NESSUS_TOKEN"
        echo "Already logged out."
        return
    end

    echo "Logging out..."
    curl -k1 -H "X-Cookie: token=$TOKEN" "https://"(hostname -f)":8834/session" -X DELETE >/dev/null 2>&1
    set -xg NESSUS_TOKEN
    echo "Success"

end
