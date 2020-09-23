#!/bin/bash

# import-us-wv-shp-files.sh
# Copyright (C) 2012-2013,2016 Brian Masney <masneyb@onstation.org>
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

set -e # Exit if any commands fail
set -u # Warn about uninitialized variables

REL_BASE_DIR=$(dirname "$0")/../..
BASE_DIR=$(readlink -f "${REL_BASE_DIR}")
. "${BASE_DIR}"/bin/gis-common

DEST_DB=${1:-}
DEST_SRID=${2:-}

if [ "${DEST_DB}" = "" ] || [ "${DEST_SRID}" = "" ] ; then
	echo "usage: $0 <destination database> <destination srid>" >&2
	exit 1
fi

init_postgis_db "${DEST_DB}"

DEST_DIR="${BASE_DIR}"/download/us_wv/other
DEM_DIR="${BASE_DIR}"/download/us_wv/dem
#USDA_2014_AERIAL_DIR="${BASE_DIR}"/download/us_wv/aerial/USDA-2014

download_and_import_file \
	ftp://ftp.wvgis.wvu.edu/pub/Clearinghouse/transportation/interstateHighways/interstateHighwaysWV_USDOT_1997_utm83_shp.zip \
	"${DEST_DIR}"/interstateHighwaysWV_USDOT_1997_utm83_shp.zip \
	interstateHighwaysWV_USDOT_1997_utm83.shp \
	26917 \
	wv_interstates \
	"" \
	"" \
	"${DEST_DB}" \
	"${DEST_SRID}"

download_and_import_file \
	ftp://ftp.wvgis.wvu.edu/pub/Clearinghouse/Transportation/roadsUSHighways_USCensus_1997_utm83_shp.zip \
	"${DEST_DIR}"/roadsUSHighways_USCensus_1997_utm83_shp.zip \
	roadsUSHighways_USCensus_1997_utm83.shp \
	26917 \
	wv_us_highways \
	"" \
	"" \
	"${DEST_DB}" \
	"${DEST_SRID}"

download_and_import_file \
	ftp://ftp.wvgis.wvu.edu/pub/Clearinghouse/transportation/roadsAndRailroads_usCensus/roads_USCensus_2011_utm83_shp.zip \
	"${DEST_DIR}"/roads_USCensus_2011_utm83_shp.zip \
	roads_USCensus_2011_UTM83.shp \
	26917 \
	wv_census_roads \
	"" \
	"" \
	"${DEST_DB}" \
	"${DEST_SRID}"

download_and_import_file \
	ftp://ftp.wvgis.wvu.edu/pub/Clearinghouse/inlandWaters/4800HydrologicFeatureGeometry_NHD_2003_utm83/STATEWIDE_lr_hydro_utm83.zip \
	"${DEST_DIR}"/STATEWIDE_lr_hydro_utm83.zip \
	lr_hydro_polygons_all.shp \
	26917 \
	wv_water_polygons \
	"" \
	"" \
	"${DEST_DB}" \
	"${DEST_SRID}"

download_and_import_file \
	ftp://ftp.wvgis.wvu.edu/pub/Clearinghouse/inlandWaters/4800HydrologicFeatureGeometry_NHD_2003_utm83/STATEWIDE_lr_hydro_utm83.zip \
	"${DEST_DIR}"/STATEWIDE_lr_hydro_utm83.zip \
	lr_hydro_lines_all.shp \
	26917 \
	wv_hydro \
	"" \
	"Entity,MAJOR1,MINOR1,MAJOR2,MINOR2,SCALE,TEXT_DESC,ComID,Resolution,GNIS_ID,GNIS_Name,LengthKM,ReachCode,FlowDir,WBAreaComI,FType,FCode,HUC,Shape_Leng" \
	"${DEST_DB}" \
	"${DEST_SRID}"

download_and_import_file \
	ftp://ftp.wvgis.wvu.edu/pub/Clearinghouse/transportation/railroads_RTI_2005_UTM83_shp.zip \
	"${DEST_DIR}"/railroads_RTI_2005_UTM83_shp.zip \
	railroads_rahallTransportationInstitute_2005_UTM83.shp \
	26917 \
	wv_census_rails \
	"" \
	"" \
	"${DEST_DB}" \
	"${DEST_SRID}"

download_and_import_file \
	ftp://ftp.wvgis.wvu.edu/pub/Clearinghouse/Transportation/miscellaneousTransportation_USCensus_2000_utm83.zip \
	"${DEST_DIR}"/miscellaneousTransportation_USCensus_2000_utm83.zip \
	miscellaneousTransportation_USCensus_2000_utm83.shp \
	26917 \
	wv_census_misc_trans \
	"" \
	"" \
	"${DEST_DB}" \
	"${DEST_SRID}"

download_and_import_file \
	ftp://ftp.wvgis.wvu.edu/pub/Clearinghouse/Transportation/recreationalWWTrailsofWV_20151117_utm83.zip \
	"${DEST_DIR}"/recreationalTrailsofWV_manysources_20151117_utm83.zip \
	recreationalWWTrailsofWV_20151117_utm83/recreationalWWTrails_ofWV_20151117_utm83.shp \
	26917 \
	wv_trails \
	"" \
	"OBJECTID,dataAgency,dataLink,trailName,trailNumbe,trailStatu,trailLengt,sharedSyst,trailSurfa,adminOrg,manageOrg,congress,county,jurisdic,municip,state,trailSyste,roadSystem,landUsePla,maintainer,trailClass,hike,bike,horse,xcski,backpack,interp,fitness,ada,water,motorized,atv,ohv,dirtbike,prohibUse,accessStat,historic,nationalTr,rightsOfWa,condition,mgmtArea,sourceData,Shape_Leng,Shape_Le_1" \
	"${DEST_DB}" \
	"${DEST_SRID}"

download_and_import_file \
	ftp://ftp.wvgis.wvu.edu/pub/Clearinghouse/location/indexGrid24kQuads_USGS_utm83_shp.zip \
	"${DEST_DIR}"/indexGrid24kQuads_USGS_utm83_shp.zip \
	indexGrid24kQuads_USGS_utm83.shp \
	26917 \
	wv_7_5_index_grid \
	"" \
	"" \
	"${DEST_DB}" \
	"${DEST_SRID}"

download_and_import_file \
	ftp://ftp.wvgis.wvu.edu/pub/Clearinghouse/boundaries/nationalForestBoundaries/nationalForestOwnership_USFWS_20181016_utm83_shp.zip \
	"${DEST_DIR}"/nationalForestOwnership_USFWS_20181016_utm83_shp.zip \
	nationalForestOwnership_USFWS_20181016_utm83.shp \
	26917 \
	wv_national_forests \
	"" \
	"" \
	"${DEST_DB}" \
	"${DEST_SRID}"

download_and_import_file \
	ftp://ftp.wvgis.wvu.edu/pub/Clearinghouse/boundaries/nationalParkBoundaries_nationalParkService_200309_utm83_shp.zip \
	"${DEST_DIR}"/nationalParkBoundaries_nationalParkService_200309_utm83_shp.zip \
	nationalParkBoundaries_nationalParkService_200309_utm83.shp \
	26917 \
	wv_national_parks \
	"" \
	"" \
	"${DEST_DB}" \
	"${DEST_SRID}"

download_and_import_file \
	ftp://ftp.wvgis.wvu.edu/pub/Clearinghouse/Boundaries/wvStateForestBoundaries_wvdof_092015_utm83.zip \
	"${DEST_DIR}"/wvStateForestBoundaries_wvdof_092015_utm83.zip \
	wvStateForestBoundaries_wvdof_092015_utm83.shp \
	26917 \
	wv_state_forests \
	"" \
	"" \
	"${DEST_DB}" \
	"${DEST_SRID}"

download_and_import_file \
	ftp://ftp.wvgis.wvu.edu/pub/Clearinghouse/boundaries/stateParkBoundaries_WVDNR_2000_utm83_shp.zip \
	"${DEST_DIR}"/stateParkBoundaries_WVDNR_2000_utm83_shp.zip \
	stateParkBoundaries_WVDNR_2000_utm83.shp \
	26917 \
	wv_state_parks \
	"" \
	"" \
	"${DEST_DB}" \
	"${DEST_SRID}"

download_and_import_file \
	ftp://ftp.wvgis.wvu.edu/pub/Clearinghouse/boundaries/wildlifeManagementAreas/wvdnrManagedLands_wvdnr_20200916_utm83_shp.zip \
	"${DEST_DIR}"/wvdnrManagedLands_wvdnr_20200916_utm83_shp.zip \
	wvdnrManagedLands_wvdnr_20200916_utm83.shp \
	26917 \
	wvdnr_managed_lands \
	"" \
	"" \
	"${DEST_DB}" \
	"${DEST_SRID}"

download_and_import_file \
	ftp://ftp.wvgis.wvu.edu/pub/Clearinghouse/boundaries/countyBoundary_censusAndUSGS_200503_utm83_shp.zip \
	"${DEST_DIR}"/countyBoundary_censusAndUSGS_200503_utm83_shp.zip \
	countyBoundary_censusAndUSGS_200503_utm83.shp \
	26917 \
	wv_counties \
	"" \
	"" \
	"${DEST_DB}" \
	"${DEST_SRID}"
	
download_and_import_file \
	ftp://ftp.wvgis.wvu.edu/pub/Clearinghouse/Boundaries/IncorporatedPlaces_Census_201111_UTM83.zip \
	"${DEST_DIR}"/IncorporatedPlaces_Census_201111_UTM83.zip \
	IncorporatedPlaces_Census_201111_UTM83.shp \
	26917 \
	wv_census_places2000 \
	"" \
	"" \
	"${DEST_DB}" \
	"${DEST_SRID}"

download_and_import_file \
	ftp://ftp.wvgis.wvu.edu/pub/Clearinghouse/geoscience/geologyKarstFormations_WVGES_1968_utm83_shp.zip \
	"${DEST_DIR}"/geologyKarstFormations_WVGES_1968_utm83_shp.zip \
	geologyKarstFormations_WVGES_1968_utm83_shp/geologyKarstFormations_WVGES_1968_utm83.shp \
	26917 \
	wv_karst \
	"" \
	"" \
	"${DEST_DB}" \
	"${DEST_SRID}"

download_and_import_file \
	ftp://ftp.wvgis.wvu.edu/pub/Clearinghouse/elevation/summits_GISTC_052012_utm83_shp.zip \
	"${DEST_DIR}"/summits_GISTC_052012_utm83_shp.zip \
	summits_GISTC_052012_utm83_shp.shp \
	26917 \
	wv_summits \
	"" \
	"" \
	"${DEST_DB}" \
	"${DEST_SRID}"

# Generate contour lines from the DEM files

HUNDRED_FT_TABLE="wv_100ft_contours"
TWENTY_FT_TABLE="wv_20ft_contours"
CONTOUR_SRC_SRID="26917"

CONTOUR_TABLE_EXISTS=$(does_postgresql_table_exist "${DEST_DB}" "${HUNDRED_FT_TABLE}")
if [ "${CONTOUR_TABLE_EXISTS}" = "0" ] ; then
	create_contour_table "${DEST_DB}" "${DEST_SRID}" "${HUNDRED_FT_TABLE}"
	create_contour_table "${DEST_DB}" "${DEST_SRID}" "${TWENTY_FT_TABLE}"

	for IN_TIF_FILE in $(find "${DEM_DIR}" -name "*.tif" | sort) ; do
	        generate_contours "${IN_TIF_FILE}" "${CONTOUR_SRC_SRID}" 100 "${HUNDRED_FT_TABLE}" "${DEST_DB}" "${DEST_SRID}"
	        generate_contours "${IN_TIF_FILE}" "${CONTOUR_SRC_SRID}" 20 "${TWENTY_FT_TABLE}" "${DEST_DB}" "${DEST_SRID}"
	done
else
	echo "Not generating the contour lines since the table ${DEST_DB}.${HUNDRED_FT_TABLE} already exists"
fi


## Import aerial imagery
#
#USDA_2014_AERIAL_TABLE="wv_aerial_usda_2014"
#
#AERIAL_TABLE_EXISTS=$(does_postgresql_table_exist "${DEST_DB}" "${USDA_2014_AERIAL_TABLE}")
#if [ "${AERIAL_TABLE_EXISTS}" = "0" ] ; then
#	create_aerial_image_table "${DEST_DB}" "${USDA_2014_AERIAL_TABLE}"
#
#        echo ""
#        echo "Importing raster images in ${USDA_2014_AERIAL_DIR} into ${DEST_DB}.${USDA_2014_AERIAL_TABLE}."
#
#	raster2pgsql -e -F -I -a "${USDA_2014_AERIAL_DIR}"/*.jp2 "${USDA_2014_AERIAL_TABLE}" | psql "${DEST_DB}"
#else
#	echo "Not importing the aerial imagery since the table ${DEST_DB}.${USDA_2014_AERIAL_TABLE} already exists"
#fi

