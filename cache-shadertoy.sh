cat presentation/index.html \
| ggrep -oP 'shadertoy\.com/embed/\K\w+' \
| sort | uniq > shader_ids.txt

mkdir -p cached_shaders

while read ID; do
    echo "Caching shader: $ID"
    curl 'https://www.shadertoy.com/shadertoy' \
      -H 'Accept: */*' \
      -H 'Accept-Language: en-US,en;q=0.9' \
      -H 'Cache-Control: no-cache' \
      -H 'Connection: keep-alive' \
      -H 'Content-Type: application/x-www-form-urlencoded' \
      -H 'Origin: https://www.shadertoy.com' \
      -H "Referer: https://www.shadertoy.com/view/$ID" \
      -H 'Sec-Fetch-Dest: empty' \
      -H 'Sec-Fetch-Mode: cors' \
      -H 'Sec-Fetch-Site: same-origin' \
      -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36' \
      -H 'sec-ch-ua: "Google Chrome";v="137", "Chromium";v="137", "Not/A)Brand";v="24"' \
      -H 'sec-ch-ua-mobile: ?0' \
      -H 'sec-ch-ua-platform: "macOS"' \
      --data-urlencode "s={\"shaders\":[\"$ID\"]}" \
      --data-raw 'nt=0&nl=0&np=0' \
      --compressed \
      --output "cached_shaders/shader_${ID}.json"
    sleep 1
done < shader_ids.txt
