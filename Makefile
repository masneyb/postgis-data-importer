# WGS84 - http://spatialreference.org/ref/epsg/4326/
DEST_SRID=4326
US_WV_DB=wvgis

us_wv:
	# Downloads the DEM files
	./bin/us_wv/download-us-wv-dem-files.sh

	# Download the aerial imagery. Run the download process with the full
	# path so that the generated mapserver map files have the full path.
	`pwd`/bin/us_wv/download-us-wv-usda-2014-aerial-images.sh

	# Downloads various SHP files. Generates 20 foot and 100 foot
	# contours based on the DEM files downloaded above.
	./bin/us_wv/import-us-wv-shp-files.sh "${US_WV_DB}" "${DEST_SRID}"

shellcheck:
	shellcheck bin/us_wv/download-us-wv-dem-files.sh
	shellcheck bin/us_wv/import-us-wv-shp-files.sh
	shellcheck bin/us_wv/download-us-wv-usda-2014-aerial-images.sh
