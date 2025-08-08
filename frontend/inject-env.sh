#!/bin/sh

echo "Generando /usr/share/nginx/html/env.json..."

cat <<EOF > /usr/share/nginx/html/env.json
{
  "REACT_APP_API_URL": "${REACT_APP_API_URL}"
}
EOF