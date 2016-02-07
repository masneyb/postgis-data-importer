# WGS84 - http://spatialreference.org/ref/epsg/4326/
DEST_SRID=4326

MRSID_DECODE=/home/masneyb/MrSID_DSDK-9.5.1.4427-linux.x86-64.gcc48/Raster_DSDK/bin/mrsiddecode
KEEP_MRSID_AERIAL_IMAGES=0

us_wv:
	# Downloads the DEM files
	./bin/us_wv/download-us-wv-dem-files.sh

	# Downloads various SHP files. Generates 20 foot and 100 foot
	# contours based on the DEM files downloaded above.
	./bin/us_wv/import-us-wv-shp-files.sh wvgis "${DEST_SRID}"

	# Download the aerial imagery. Run the download process with the full
	# path so that the generated mapserver map files have the full path.
	`pwd`/bin/us_wv/download-us-wv-usda-2014-aerial-images.sh "${MRSID_DECODE}" "${KEEP_MRSID_AERIAL_IMAGES}"

shellcheck:
	shellcheck bin/us_wv/download-us-wv-dem-files.sh
	shellcheck bin/us_wv/import-us-wv-shp-files.sh
	shellcheck bin/us_wv/download-us-wv-usda-2014-aerial-images.sh
