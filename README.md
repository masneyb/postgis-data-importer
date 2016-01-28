# wv-postgis

I use this script to import various SHP files from the
[West Virginia GIS Technical Center](http://wvgis.wvu.edu/) into a
PostgreSQL/PostGIS database. This ensures that all layers use the
same spatial reference system ID (SRID) to speed up read requests. The
script also generates 20 foot and 100 foot contour lines from a list of
digital elevation model (DEM) files.


## Installation (Fedora 23)
	
* Install dependencies: `sudo dnf install postgis postgresql postgresql-server`
* Setup database directory: `sudo postgresql-setup --initdb --unit postgresql`
* Create PostgreSQL super user (note: gives access to other DBs): `sudo -u postgres createuser -s USERNAME_THAT_YOU_WILL_RUN_THIS_AS`
* If you would like to generate contour lines, then download the appopriate DEM ZIP
  files for the areas that you want to contour from
  http://wvgis.wvu.edu/data/dataset.php?ID=261 into the _download/us_wv/dem/_ directory.
* Run `make` to import the data into the wvgis PostgreSQL database. The Makefile
  has a few settings that you may want to change.

