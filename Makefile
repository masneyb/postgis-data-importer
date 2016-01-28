POSTGIS_SQL_FILE=/usr/share/pgsql/contrib/postgis-2.1/postgis.sql
SPATIAL_REF_SYS_SQL_FILE=/usr/share/pgsql/contrib/postgis-2.1/spatial_ref_sys.sql

us_wv:
	./import-us-wv-shp-files.sh wvgis 4326 "${POSTGIS_SQL_FILE}" "${SPATIAL_REF_SYS_SQL_FILE}"
