function nlogin
    if not test -z "$NESSUS_TOKEN"
        if test "$argv[1]" != "-f"
            echo "Already logged in with token $NESSUS_TOKEN"
            return
        end
    end

    echo "Logging in..."
    set -xg NESSUS_TOKEN (node -p "var obj="(curl -k1 -d username="duybui" -d password="Aw5%3D141592" "https://"(hostname -f)":8834/session" 2>/dev/null)"; obj.token")
    echo "Success with token $NESSUS_TOKEN"
end
