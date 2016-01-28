#!/bin/bash

set -e # Exit if any commands fail
set -u # Warn about uninitialized variables

. "$(dirname "$0")"/gis-common

# FIXME - read from command line
DEST_DB=wvgis
DEST_SRID=4326
POSTGIS_SQL_FILE=/usr/share/pgsql/contrib/postgis-2.1/postgis.sql
SPATIAL_REF_SYS_SQL_FILE=/usr/share/pgsql/contrib/postgis-2.1/spatial_ref_sys.sql
# Older Debian-based systems
# POSTGIS_SQL_FILE=/usr/share/postgresql/9.1/contrib/postgis-1.5/postgis.sql
# SPATIAL_REF_SYS_SQL_FILE=/usr/share/postgresql/9.1/contrib/postgis-1.5/spatial_ref_sys.sql
INIT_DB=1


if [ "${INIT_DB}" = "1" ] ; then
	init_postgis_db "${DEST_DB}" "${POSTGIS_SQL_FILE}" "${SPATIAL_REF_SYS_SQL_FILE}"
fi

DEST_DIR=$(dirname "$0")/download/us_wv/other
mkdir -p "${DEST_DIR}"

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

# FIXME - old file was recreationalTrailsOfWV_manySourcesWvgistc_20110803_utm83_shp.zip
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
	ftp://ftp.wvgis.wvu.edu/pub/Clearinghouse/boundaries/nationalForestBoundaries/nationalForestSurfaceOwnership_USFS_2005_utm83_shp.zip \
	"${DEST_DIR}"/nationalForestSurfaceOwnership_USFS_2005_utm83_shp.zip \
	nationalForestSurfaceOwnership_USFS_2005_utm83.shp \
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

# FIXME - old file was stateForestBoundaries_WVDNR_200405_utm83_shp.zip
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

# FIXME - old file was wildlifeManagementAreas_WVDNR_12092011_utm83_shp.zip
# FIXME - change table name to wvdnr_managed_lands
download_and_import_file \
	ftp://ftp.wvgis.wvu.edu/pub/Clearinghouse/boundaries/wildlifeManagementAreas/wvdnrManagedLands_wvdnr_10092015_utm83_shp.zip \
	"${DEST_DIR}"/wvdnrManagedLands_wvdnr_10092015_utm83_shp.zip \
	wvdnrManagedLands_wvdnr_10092015_utm83_shp/wvdnrManagedLands_wvdnr_10092015_utm83.shp \
	26917 \
	wv_wildlife_management_areas \
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
	
# FIXME - old file was incorporatedPlacesWithCDPs_USCensus_200803_UTM83_shp.zip
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
	geologyKarstFormations_WVGES_1968_utm83.shp \
	26917 \
	wv_karst \
	"" \
	"" \
	"${DEST_DB}" \
	"${DEST_SRID}"

# FIXME - move into national script
# FIXME - old file was usastates_st99_d00_shp.zip
download_file \
	http://www2.census.gov/geo/tiger/GENZ2014/shp/cb_2014_us_state_500k.zip \
	"${DEST_DIR}"/cb_2014_us_state_500k.zip

