# wv-postgis

I use this script to import various SHP files from the
[West Virginia GIS Technical Center](http://wvgis.wvu.edu/) into a
PostgreSQL/PostGIS database. This ensures that all layers use the
same spatial reference system ID to speed up read requests. The
script also generates 20' and 100' contour lines from a list of
DEM files.


## Installation
	
* `sudo apt-get update`
* `sudo apt-get install postgresql-VERSION postgresql-VERSION-postgis postgresql-client-VERSION postgresql-client-common postgresql-common postgis`
* su to the postgresql user and run `createuser -s <user this will run as>`
* Download the GIS data (see below) and extract the ZIP files into this
  toplevel directory.
* Optional: Download any DEM files into download/dem/ for regions that you
  would to generate contour lines for.


## GIS Data Sources

This script currently uses the following data sources from the
[West Virginia GIS Technical Center](http://wvgis.wvu.edu/).

* countyBoundary_censusAndUSGS_200503_utm83_shp.zip
* geologyKarstFormations_WVGES_1968_utm83_shp.zip
* highResolutionNHDWV_USGS_062011_gcs83_gdb.zip
* incorporatedPlacesWithCDPs_USCensus_200803_UTM83_shp.zip
* indexGrid24kQuads_USGS_utm83_shp.zip
* interstateHighwaysWV_USDOT_1997_utm83_shp.zip
* nationalForestSurfaceOwnership_USFS_2005_utm83_shp.zip
* nationalParkBoundaries_nationalParkService_200309_utm83_shp.zip
* railroads_RTI_2005_UTM83_shp.zip
* recreationalTrailsOfWV_manySourcesWvgistc_20110803_utm83_shp.zip
* roads_USCensus_2011_UTM83.zip
* roadsUSHighways_USCensus_1997_utm83_shp.zip
* stateForestBoundaries_WVDNR_200405_utm83_shp.zip
* stateParkBoundaries_WVDNR_2000_utm83_shp.zip
* STATEWIDE_lr_hydro_utm83.zip
* usastates_st99_d00_shp.zip
* wildlifeManagementAreas_WVDNR_12092011_utm83_shp.zip

TODO: Add a script that downloads the necessary dependencies.

