POSTGIS_SQL_FILE=/usr/share/pgsql/contrib/postgis-2.1/postgis.sql
SPATIAL_REF_SYS_SQL_FILE=/usr/share/pgsql/contrib/postgis-2.1/spatial_ref_sys.sql
DEST_SRID=4326 # WGS84 - http://spatialreference.org/ref/epsg/4326/

us_wv:
	./import-us-wv-shp-files.sh wvgis "${DEST_SRID}" "${POSTGIS_SQL_FILE}" "${SPATIAL_REF_SYS_SQL_FILE}"
