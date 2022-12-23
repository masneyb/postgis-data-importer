# postgis-data-importer

This script is used to import various SHP files from the
[West Virginia GIS Technical Center](http://wvgis.wvu.edu/) into a
PostgreSQL/PostGIS database. This ensures that all layers use the
same spatial reference system (SRID) ID to speed up read requests.

The following imagery are also downloaded or generated:

- [2014 USDA](http://wvgis.wvu.edu/data/dataset.php?ID=461) - The
  latest publicly available aerial imagery of West Virginia. This
  imagery was taken when the leaves were on the trees. These files
  are in JP2 format.
- [2003 SAMB](http://wvgis.wvu.edu/data/dataset.php?ID=254) - This
  imagery was taken when the leaves were off the trees and more
  detail is shown on the ground. These files use the proprietary
  MrSID file format. The download process uses their SDK to convert
  these files into JPGs.
- [1994 USGS Topo Quads](http://wvgis.wvu.edu/data/dataset.php?ID=95) -
  This is the latest USGS topo quads publicly available for West Virginia.
  These files are in TIF format.
- The
  [3 meter Digital Elevation Model (DEM)](http://wvgis.wvu.edu/data/dataset.php?ID=261)
  is used to generate contour lines (20 foot and 100 foot) and hillshade
  imagery in TIF format.

## Examples

See the [Monongalia / Preston Trail Maps](https://github.com/masneyb/monongalia-preston-wv-trail-maps)
project for an example of a map created using [MapServer](http://www.mapserver.org/)
with this project.

This project was primarily written to support the
[cavedbmanager](https://github.com/masneyb/cavedbmanager) project.


## Installation
	
* Install dependencies
  - RedHat/Fedora:
    - `sudo dnf install curl gdal make postgis postgis-client postgresql postgresql-server unzip`
    - Setup database directory: `sudo postgresql-setup --initdb --unit postgresql`
  - Ubuntu 18.04: `sudo apt-get install curl gdal-bin make postgis postgresql-10 postgresql-10-postgis-2.4 postgresql-client unzip`
* Create PostgreSQL super user for your user account (note: gives full access to other DBs):
  `sudo -u postgres createuser -s "$(whoami)"`
* If you'd like to download the SAMB 2003 aerial imagery, then download the
  [GeoExpress Command Line Applications](https://www.lizardtech.com/gis-tools/tools-and-utilities)
  from Lizard Tech's website.
  - Edit the settings at the top of the _Makefile_. You will need to uncomment
    the call to _download-us-wv-samb-2003-aerial-images.sh_ in the Makefile if
    you downloaded Lizard Tech's SDK.
* Examine the bottom of the 
  [DEM](bin/us_wv/download-us-wv-dem-files.sh),
  [2014 aerial](bin/us_wv/download-us-wv-usda-2014-aerial-images.sh),
  [2003 aerial](bin/us_wv/download-us-wv-samb-2003-aerial-images.sh), and
  [1994 USGS](bin/us_wv/download-us-wv-usgs-topo-1994.sh) import scripts to
  ensure that the data is downloaded for your areas of interest. It is currently
  configured to download the data for all regions that are underlain by karst.
* Run `make` to import the vector data into the _wvgis_ PostgreSQL database.


## Space Requirements

This table shows how much disk space is required to download and install
the various components if the defaults are used.

Data Set | Vector Layers |  DEMs  | 2014 Aerial Imagery (JP2s) | 2003 Aerial Imagery (JPGs) | PostgreSQL DB  |  HillShade | USGS 1994 | Total   |
---------|---------------|--------|----------------------------|----------------------------|----------------|------------|-----------|---------|
us_wv    |        496 MB | 1.6 GB |                      14 GB |                      13 GB |        30.0 GB |     7.9 GB |    1.5 GB | 68.5 GB |

