#!/bin/bash

# download-us-wv-dem-files.sh
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

BASE_DIR=$(dirname "$0")/../..
. "${BASE_DIR}"/bin/gis-common

BASE_URL="ftp://ftp.wvgis.wvu.edu/pub/Clearinghouse/elevation/3MeterDEM_SAMB_2003_utm83/tiff/zipped"
DEST_DIR="${BASE_DIR}"/download/us_wv/dem

download_dem()
{
	FILENAME=$1

	download_file "${BASE_URL}"/"${FILENAME}" "${DEST_DIR}"/"${FILENAME}"
}

download_dem lake_lynn_pa_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem masontown_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem morgantown_north_wv_pa_USGSAndSAMB_2003_utm83_tif.zip
download_dem morgantown_south_wv_USGSAndSAMB_2003_utm83_tif.zip
