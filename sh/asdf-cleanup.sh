#! /usr/bin/env sh

# echo "Finding all versions in use"
# fd --hidden .tool-versions ~ | xargs cat | sort | uniq

for plugin in $(asdf plugin list); do
    for version in $(asdf list "${plugin}" | xargs); do
        echo "Checking ${plugin} ${version}"
        if fd --hidden .tool-versions ~ | xargs cat | grep -q "${plugin} ${version}"; then
            echo "✅ in use"
        else
            echo "🗑️ removing"
            asdf uninstall "${plugin}" "${version}"
        fi
    done
done
