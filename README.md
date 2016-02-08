# postgis-data-importer

This script is used to import various SHP files from the
[West Virginia GIS Technical Center](http://wvgis.wvu.edu/) into a
PostgreSQL/PostGIS database. This ensures that all layers use the
same spatial reference system (SRID) ID to speed up read requests. The
script generates contour lines (20 foot and 100 foot intervals)
from a list of digital elevation model (DEM) files. Aerial imagery
and a corresponding mapserver file is also generated.

## Examples

See the [Monongalia / Preston Trail Maps](https://github.com/masneyb/monongalia-preston-wv-trail-maps)
project for an example of a map created using [MapServer](http://www.mapserver.org/)
with this project.

This project was primarily written to support the
[cavedbmanager](https://github.com/masneyb/cavedbmanager) project.


## Installation
	
* Install dependencies
  - RedHat/Fedora:
    - `sudo dnf install make unzip postgis postgresql postgresql-server gdal`
    - Setup database directory: `sudo postgresql-setup --initdb --unit postgresql`
  - Debian/Ubuntu: `sudo apt-get install make unzip postgis postgresql-client postgresql-9.4 gdal-bin`
* Create PostgreSQL super user for your user account (note: gives full access to other DBs):
  `MY_USER=$(whoami) && sudo -u postgres createuser -s "${MY_USER}"`
* Edit the settings at the top of the _Makefile_.
* Examine the bottom of the 
  [DEM](bin/us_wv/download-us-wv-dem-files.sh) and
  [aerial](bin/us_wv/download-us-wv-usda-2014-aerial-images.sh) import scripts
  to ensure that the data is downloaded for your area of interest. It is currently
  configured to download the data for all regions that are underlain by karst.
* Run `make` to import the vector data into the _wvgis_ PostgreSQL database.


## Space Requirements

This table shows how much disk space is required to download and install
the various components if the defaults are used.

Data Set | Vector Layers |  DEMs  | Aerial Imagery | PostgreSQL DB |  Total  |
---------|---------------|--------|----------------|---------------|---------|
us_wv    |        496 MB | 1.6 GB |          14 GB |        9.0 GB | 25.1 GB |

The vector layer and DEM files can be deleted once everything has been
imported into PostgreSQL. It is recommended to keep these files in case
you need to recreate your PostgreSQL database.

