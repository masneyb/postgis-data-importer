#!/bin/bash

# create-us-wv-hillshade.sh
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

DEST_DIR="${BASE_DIR}"/download/us_wv/hillshade
DEM_DIR="${BASE_DIR}"/download/us_wv/dem

MAPSERVER_FILE="${DEST_DIR}"/hillshade.map

# Clear the mapserver files since this script appends to them
rm -f "${MAPSERVER_FILE}"

append_to_mapserver_file()
{
	LAYER_NAME=$1
	FILE=$2

	cat >> "${MAPSERVER_FILE}" << __EOF__
LAYER
	NAME ${LAYER_NAME}
	DATA "${FILE}"
	OFFSITE 0 0 0
	STATUS ON
	TYPE RASTER
	CLASS
		MAXSCALE 60000.00
	END
	PROJECTION
		"+proj=utm"
		"+zone=17"
		"+ellps=GRS80"
		"+datum=NAD83"
		"+units=m"
		"+no_defs"
	END
END
__EOF__
}

for IN_ZIP_FILE in $(find "${DEM_DIR}" -name "*.zip" | sort) ; do
	CONTOUR_TMPDIR=$(mktemp -d)

        unzip -qq "${IN_ZIP_FILE}" -d "${CONTOUR_TMPDIR}"

	INPUT_FILENAME=$(find "${CONTOUR_TMPDIR}"/*.tif | head -n 1)
	BASE_FILENAME=$(basename "${INPUT_FILENAME}" | sed s/\.tif$//)
	DEST_FILENAME="${DEST_DIR}"/"${BASE_FILENAME}"_hillshade.tif

	if [ ! -f "${DEST_FILENAME}" ] ; then
		gdaldem hillshade "${CONTOUR_TMPDIR}"/"${BASE_FILENAME}".tif "${DEST_FILENAME}"
	fi

	append_to_mapserver_file "${BASE_FILENAME}" "${DEST_FILENAME}"

	rm -rf "${CONTOUR_TMPDIR}"
done

