# List of paths the PostGIS files can be installed in. Pick the
# first one that is present.
#
POSTGIS_SQL_FILE=`find \
			"/usr/share/pgsql/contrib/postgis-2.1/postgis.sql" \
			"/usr/share/postgresql/9.4/contrib/postgis-2.1/postgis.sql" \
			"/usr/share/postgresql/9.3/contrib/postgis-2.1/postgis.sql" \
			"/usr/share/postgresql/9.1/contrib/postgis-1.5/postgis.sql" \
			2>/dev/null \
			| head -n 1`
SPATIAL_REF_SYS_SQL_FILE=`find \
			"/usr/share/pgsql/contrib/postgis-2.1/spatial_ref_sys.sql" \
			"/usr/share/postgresql/9.4/contrib/postgis-2.1/spatial_ref_sys.sql" \
			"/usr/share/postgresql/9.3/contrib/postgis-2.1/spatial_ref_sys.sql" \
			"/usr/share/postgresql/9.1/contrib/postgis-1.5/spatial_ref_sys.sql" \
			2>/dev/null \
			| head -n 1`

DEST_SRID=4326 # WGS84 - http://spatialreference.org/ref/epsg/4326/

us_wv:
	./import-us-wv-shp-files.sh wvgis "${DEST_SRID}" "${POSTGIS_SQL_FILE}" "${SPATIAL_REF_SYS_SQL_FILE}"
