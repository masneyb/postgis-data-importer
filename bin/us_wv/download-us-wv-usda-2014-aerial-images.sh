#!/bin/bash

# download-us-wv-usda-2014-aerial-images.sh
#
# This script downloads the USDA 2014 aerial imagery for parts of West
# Virginia from the WV GIS Technical Center.
#
# Copyright (C) 2016 Brian Masney <masneyb@onstation.org>
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

BASE_URL="ftp://ftp.wvgis.wvu.edu/pub/Clearinghouse/ImageryBaseMaps/NAIP2014/NAIP2014_4BandImagery_compressed"

BASE_DIR=$(dirname "$0")/../..
. "${BASE_DIR}"/bin/gis-common

JP2_DEST_DIR="${BASE_DIR}"/download/us_wv/aerial/USDA-2014
JP2_MAPSERVER_FILE="${JP2_DEST_DIR}"/2014.map

# Clear the mapserver files since this script appends to them
rm -f "${JP2_MAPSERVER_FILE}"

append_to_mapserver_file()
{
	MAPSERVER_FILE=$1
	LAYER_NAME=$2
	FILE=$3

	cat >> "${MAPSERVER_FILE}" << __EOF__
LAYER
	NAME ${LAYER_NAME}
	DATA "${FILE}"
	OFFSITE 0 0 0
	STATUS ON
	TYPE RASTER
	PROJECTION
		"+proj=merc"
		"+a=6378137"
		"+b=6378137"
		"+lat_ts=0.0"
		"+lon_0=0.0"
		"+x_0=0.0"
		"+y_0=0"
		"+k=1.0"
		"+units=m"
		"+nadgrids=@null"
		"+wktext"
		"+no_defs"
	END
END
__EOF__
}

download_aerial()
{
	BASE_FILENAME=$1

	JP2_DEST_FILENAME="${JP2_DEST_DIR}"/"${BASE_FILENAME}"
	append_to_mapserver_file "${JP2_MAPSERVER_FILE}" "${BASE_FILENAME}" "${JP2_DEST_FILENAME}"
	download_file "${BASE_URL}"/"${BASE_FILENAME}" "${JP2_DEST_FILENAME}"
}

download_aerial LAKE_LYNN_NE_NAIP_USDA_2014_utm83.jp2
download_aerial LAKE_LYNN_NW_NAIP_USDA_2014_utm83.jp2
download_aerial LAKE_LYNN_SE_NAIP_USDA_2014_utm83.jp2
download_aerial LAKE_LYNN_SW_NAIP_USDA_2014_utm83.jp2

