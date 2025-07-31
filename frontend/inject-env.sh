#!/bin/sh

echo "Inyectando API_URL en /env.json → ${API_URL}"

cat <<EOF > /usr/share/nginx/html/env.json
{
  "API_URL": "${API_URL}"
}
EOF