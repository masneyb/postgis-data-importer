# postgis-data-importer

This script is used to import various SHP files from the
[West Virginia GIS Technical Center](http://wvgis.wvu.edu/) into a
PostgreSQL/PostGIS database. This ensures that all layers use the
same spatial reference system ID (SRID) to speed up read requests. The
script generates contour lines (20 foot and 100 foot intervals)
from a list of digital elevation model (DEM) files.

This script also downloads aerial imagery and converts the non-free
MrSID files into JPGs.


## Example

See the [Monongalia / Preston Trail Maps](https://github.com/masneyb/monongalia-preston-wv-trail-maps)
project for an example of a map created using [MapServer](http://www.mapserver.org/)
with this project.


## Installation
	
* Install dependencies
  - RedHat/Fedora:
    - `sudo dnf install make unzip postgis postgresql postgresql-server gdal`
    - Setup database directory: `sudo postgresql-setup --initdb --unit postgresql`
  - Debian/Ubuntu: `sudo apt-get install make unzip postgis postgresql-client postgresql-9.4 gdal-bin`
* Create PostgreSQL super user for your user account (note: gives full access to other DBs):
  `MY_USER=$(whoami) && sudo -u postgres createuser -s "${MY_USER}"`
* If you'd like to download the aerial imagery, register for a developer account with
  [Lizard Tech](https://www.lizardtech.com/developer/) and download the unified SDK.
* Edit the settings at the top of the _Makefile_.
* Examine the bottom of the DEM and aerial import script
  (_bin/us_wv/download-us-wv-dem-files.sh_ and
  _bin/us_wv/download-us-wv-usda-2014-aerial-images.sh_) to ensure that the
  data is downloaded for the area of interest.
* Run `make` to import the data into the _wvgis_ PostgreSQL database.

