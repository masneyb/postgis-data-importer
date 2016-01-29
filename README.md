# postgis-data-importer

This script is used to import various SHP files from the
[West Virginia GIS Technical Center](http://wvgis.wvu.edu/) into a
PostgreSQL/PostGIS database. This ensures that all layers use the
same spatial reference system ID (SRID) to speed up read requests. The
script also generates contour lines from a list of digital elevation
model (DEM) files.

## Example

See the [Coopers Rock Trails](https://github.com/masneyb/coopers-rock-trails)
project for an example of a map created using [MapServer](http://www.mapserver.org/)
with this project.


## Installation (Fedora 23)
	
* Install dependencies
  - RedHat/Fedora: `sudo dnf install postgis postgresql postgresql-server`
* Setup database directory: `sudo postgresql-setup --initdb --unit postgresql`
* Create PostgreSQL super user for your user account (note: gives access to other DBs):
  `MY_USER=$(whoami) && sudo -u postgres createuser -s "${MY_USER)"`
* If you would like to generate contour lines, then download the appopriate DEM ZIP
  files for the areas that you want to contour from
  http://wvgis.wvu.edu/data/dataset.php?ID=261 into the _download/us_wv/dem/_ directory.
* Run `make` to import the data into the wvgis PostgreSQL database. The Makefile
  has a few settings that you may want to change.

