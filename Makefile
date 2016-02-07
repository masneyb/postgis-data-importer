# WGS84 - http://spatialreference.org/ref/epsg/4326/
DEST_SRID=4326

MRSID_DECODE=/home/masneyb/MrSID_DSDK-9.5.1.4427-linux.x86-64.gcc48/Raster_DSDK/bin/mrsiddecode
KEEP_MRSID_AERIAL_IMAGES=0

CURRENT_DIRECTORY=`pwd`

us_wv:
	./bin/us_wv/import-us-wv-shp-files.sh wvgis "${DEST_SRID}"

	# Run the download process with the full path so that the mapserver map file
	# has the full path.
	${CURRENT_DIRECTORY}/bin/us_wv/download-us-wv-usda-2014-aerial-images.sh "${MRSID_DECODE}" "${KEEP_MRSID_AERIAL_IMAGES}"

shellcheck:
	shellcheck bin/us_wv/import-us-wv-shp-files.sh
	shellcheck bin/us_wv/download-us-wv-usda-2014-aerial-images.sh
