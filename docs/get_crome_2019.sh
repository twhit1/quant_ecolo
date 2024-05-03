#!/bin/bash
#
# Usage from Python like 
# subprocess.run('<path/to/this/script> ' + \
#                       '\"' + '<path/to/download/dir>' + '\" ' + \
#                       '\'' + f'{{"coordinates": {np.array2string(np.dstack(aoi_bbox_geodetic), precision=8, separator=",", suppress_small=True)},"type":"Polygon"}}'.replace("\n", "") + '\'',
#           shell=True)
#
# where aoi_bbox_geodetic is an EPSG:4326 shapely geometry
#
# CROME data is open access under the Open Gov Licence (UK), see https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/ 

echo "$1"
echo "$2"
curl -o ./_temp.zip \
 'https://environment.data.gov.uk/backend/catalog/api/geospatial/query?layer=cf4b59e6-693a-49d3-b992-0d75f6b29e40' \
  -H 'authority: environment.data.gov.uk' \
  -H 'accept: application/zipped-shapefile' \
  -H 'accept-language: en-GB,en-US;q=0.9,en;q=0.8,fr-CH;q=0.7,fr;q=0.6' \
  -H 'content-type: application/geo+json' \
  -H 'cookie: defra-cookie-acceptance-version=1; defra-cookie-acceptance-level=true; defra-cookie-banner-dismissed=true; _ga_12JL3WT6ZY=GS1.1.1708088880.1.1.1708089921.0.0.0; _ga=GA1.3.807862563.1708086246' \
  -H 'origin: https://environment.data.gov.uk' \
  -H 'referer: https://environment.data.gov.uk/explore/b498a2be-f3de-49fb-91a4-3381bb3868c2' \
  -H 'sec-ch-ua: "Not A(Brand";v="99", "Google Chrome";v="121", "Chromium";v="121"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36' \
  --data-raw "$2"

unzip ./_temp.zip -d "$1"

rm -rf ./_temp.zip
