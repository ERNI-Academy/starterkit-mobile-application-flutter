rm -d -R .secrets
mkdir .secrets
echo -n "$1" | base64 --decode > .secrets/$2.secrets