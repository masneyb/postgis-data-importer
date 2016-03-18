# Be sure to uncomment the call to download-us-wv-samb-2003-aerial-images.sh
# below if you download the MrSID DSDK
MRSID_DECODE=/home/masneyb/MrSID_DSDK-9.5.1.4427-linux.x86-64.gcc48/Raster_DSDK/bin/mrsiddecode
KEEP_MRSID_AERIAL_IMAGES=0

# WGS84 - http://spatialreference.org/ref/epsg/4326/
DEST_SRID=4326
US_WV_DB=wvgis

us_wv:
	# Downloads the DEM files
	./bin/us_wv/download-us-wv-dem-files.sh

	# Download the aerial imagery. Run the download process with the full
	# path so that the generated mapserver map files have the full path.
	`pwd`/bin/us_wv/download-us-wv-usda-2014-aerial-images.sh
	#`pwd`/bin/us_wv/download-us-wv-samb-2003-aerial-images.sh "${MRSID_DECODE}" "${KEEP_MRSID_AERIAL_IMAGES}"

	# Downloads various SHP files. Generates 20 foot and 100 foot
	# contours based on the DEM files downloaded above.
	./bin/us_wv/import-us-wv-shp-files.sh "${US_WV_DB}" "${DEST_SRID}"

shellcheck:
	shellcheck bin/us_wv/download-us-wv-dem-files.sh
	shellcheck bin/us_wv/import-us-wv-shp-files.sh
	shellcheck bin/us_wv/download-us-wv-samb-2003-aerial-images.sh
	shellcheck bin/us_wv/download-us-wv-usda-2014-aerial-images.sh
