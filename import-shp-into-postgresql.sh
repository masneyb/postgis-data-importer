#!/bin/sh -e

# import-shp-into-postgresql.sh
# Copyright (C) 2012-2013 Brian Masney <masneyb@onstation.org>
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

DBNAME=caves
IMPORT_COMMAND="psql $DBNAME"
DEST_SRID=4326

generate_contours() {
        INFILE=$1
        DESTDIR=$2
        INTERVAL=$3
        PG_TABLE_NAME=$4

        echo "Generating contours for file $INFILE with interval $INTERVAL"
        gdal_contour -a ele -i $INTERVAL $INFILE $DESTDIR
        import_shp 26917 $DESTDIR/contour.shp $PG_TABLE_NAME -a
}

process_contour_zip() {
	IN_ZIP_FILE=$1

	CONTOUR_TMPDIR=`mktemp -d`

	unzip $1 -d $CONTOUR_TMPDIR
	TIFF_BASE_NAME=*.tif
	generate_contours $CONTOUR_TMPDIR/$TIFF_BASE_NAME  $CONTOUR_TMPDIR/contour_100 100 wv_100ft_contours
	generate_contours $CONTOUR_TMPDIR/$TIFF_BASE_NAME  $CONTOUR_TMPDIR/contour_20 20 wv_20ft_contours

	rm -rf $CONTOUR_TMPDIR
}

import_shp() {
	SRID=$1
	SHP=$2
	TABLE=$3
	EXTRA_ARGS=$4
	LIMIT_TO_FIELDS=$5

	OGRARGS=""
	if [ $SRID != $DEST_SRID ] ; then
 		OGRARGS="-s_srs EPSG:$SRID -t_srs EPSG:$DEST_SRID $OGRARGS"
	fi
	if [ "$LIMIT_TO_FIELDS" != "" ] ; then
		OGRARGS="-select $LIMIT_TO_FIELDS $OGRARGS"
	fi

	if [ "$OGRARGS" != "" ] ; then
		TRANS_TMPDIR=`mktemp -d`
		NEW_SHP=$TRANS_TMPDIR/temp.shp
		echo "Transforming $SHP with ogr2ogr $OGRARGS via $NEW_SHP"
		ogr2ogr -skipfailures -f "ESRI Shapefile" $OGRARGS $NEW_SHP $SHP
		shp2pgsql $EXTRA_ARGS -s $DEST_SRID $NEW_SHP $TABLE | $IMPORT_COMMAND
		rm -rf $TRANS_TMPDIR
	else
		shp2pgsql $EXTRA_ARGS -s $SRID $SHP $TABLE | $IMPORT_COMMAND
	fi
}


createdb $DBNAME
echo "CREATE LANGUAGE plpgsql;" | $IMPORT_COMMAND

# RedHat-based systems
cat /usr/share/pgsql/contrib/postgis-64.sql | $IMPORT_COMMAND
cat /usr/share/pgsql/contrib/postgis-2.1/spatial_ref_sys.sql | $IMPORT_COMMAND

# Debian-based systems
# cat /usr/share/postgresql/9.1/contrib/postgis-1.5/postgis.sql | $IMPORT_COMMAND
# cat /usr/share/postgresql/9.1/contrib/postgis-1.5/spatial_ref_sys.sql | $IMPORT_COMMAND

import_shp 26917 recreationalTrailsOfWV_manySourcesWvgistc_20110803_utm83.shp wv_trails "" "OBJECTID,dataAgency,dataLink,trailName,trailNumbe,trailStatu,trailLengt,sharedSyst,trailSurfa,adminOrg,manageOrg,congress,county,jurisdic,municip,state,trailSyste,roadSystem,landUsePla,maintainer,trailClass,hike,bike,horse,xcski,backpack,interp,fitness,ada,water,motorized,atv,ohv,dirtbike,prohibUse,accessStat,historic,nationalTr,rightsOfWa,condition,mgmtArea,sourceData,Shape_Leng,Shape_Le_1"

import_shp 26917 lr_hydro_lines_all.shp wv_hydro "" "Entity,MAJOR1,MINOR1,MAJOR2,MINOR2,SCALE,TEXT_DESC,ComID,Resolution,GNIS_ID,GNIS_Name,LengthKM,ReachCode,FlowDir,WBAreaComI,FType,FCode,HUC,Shape_Leng"

# wv_census_misc_trans
import_shp 4326 wv_logging_roads.shp wv_logging_roads
import_shp 4326 coopers_rock_places.shp coopers_rock_places 
import_shp 4326 coopers_rock_trails.shp coopers_rock_trails 
import_shp 26917 indexGrid24kQuads_USGS_utm83.shp wv_7_5_index_grid 
import_shp 26917 wildlifeManagementAreas_WVDNR_12092011_utm83.shp wv_wildlife_management_areas
import_shp 26917 incorporatedPlacesWithCDPs_USCensus_200803_UTM83.shp wv_census_places2000
import_shp 26917 nationalParkBoundaries_nationalParkService_200309_utm83.shp wv_national_parks 
import_shp 26917 stateParkBoundaries_WVDNR_2000_utm83.shp wv_state_parks 
import_shp 26917 nationalForestSurfaceOwnership_USFS_2005_utm83.shp wv_national_forests 
import_shp 26917 stateForestBoundaries_WVDNR_200405_utm83.shp wv_state_forests 
import_shp 26917 geologyKarstFormations_WVGES_1968_utm83.shp wv_karst 
import_shp 26917 countyBoundary_censusAndUSGS_200503_utm83.shp wv_counties 
import_shp 26917 railroads_rahallTransportationInstitute_2005_UTM83.shp wv_census_rails 
import_shp 26917 lr_hydro_polygons_all.shp wv_water_polygons
import_shp 26917 roads_USCensus_2011_UTM83.shp wv_census_roads 
import_shp 26917 roadsUSHighways_USCensus_1997_utm83.shp wv_us_highways 
import_shp 26917 interstateHighwaysWV_USDOT_1997_utm83.shp wv_interstates 

# Generate the 100' and 20' contour tables
cat << __EOF__ | $IMPORT_COMMAND
CREATE TABLE "wv_100ft_contours" (gid serial PRIMARY KEY,
"id" int4,
"ele" float8);
SELECT AddGeometryColumn('','wv_100ft_contours','the_geom','$DEST_SRID','MULTILINESTRING',2);

CREATE TABLE "wv_20ft_contours" (gid serial PRIMARY KEY,
"id" int4,
"ele" float8);
SELECT AddGeometryColumn('','wv_20ft_contours','the_geom','$DEST_SRID','MULTILINESTRING',2);
__EOF__

# Import the contour data
for file in `find download/dem -name *.zip | sort` ; do
	process_contour_zip $file
done

