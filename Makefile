# WGS84 - http://spatialreference.org/ref/epsg/4326/
DEST_SRID=4326

us_wv:
	./import-us-wv-shp-files.sh wvgis "${DEST_SRID}"

shellcheck:
	shellcheck import-us-wv-shp-files.sh
	shellcheck download-us-wv-usda-2014-aerial-images.sh
