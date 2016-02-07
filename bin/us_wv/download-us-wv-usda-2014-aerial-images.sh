#!/bin/bash

# download-us-wv-usda-2014-aerial-images.sh
#
# This script downloads the USDA 2014 aerial imagery for parts of West
# Virginia from the WV GIS Technical Center. The MrSID files are
# converted to a JPG using the non-free Raster SDK available from
# Lizard Tech at https://www.lizardtech.com/developer/.
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

MRSID_DECODE_BINARY=${1:-}
KEEP_MRSID_FILES=${2:-}

if [ "${MRSID_DECODE_BINARY}" = "" ] || [ ! -x "${MRSID_DECODE_BINARY}" ] ; then
        echo "usage: $0 <path to mrsiddecode binary> <keep mrsid files (0|1)>" >&2
        exit 1
fi

BASE_URL="ftp://ftp.wvgis.wvu.edu/pub/Clearinghouse/ImageryBaseMaps/NAIP2014/NAIP2014_countyMosaics_compressed"

BASE_DIR=$(dirname "$0")/../..
. "${BASE_DIR}"/bin/gis-common

MRSID_DEST_DIR="${BASE_DIR}"/download/us_wv/aerial/USDA-2014/MrSID
MRSID_MAPSERVER_FILE="${MRSID_DEST_DIR}"/2014.map

JPG_DEST_DIR="${BASE_DIR}"/download/us_wv/aerial/USDA-2014/JPG
JPG_MAPSERVER_FILE="${JPG_DEST_DIR}"/2014.map

# Clear the mapserver files since this script appends to them
rm -f "${JPG_MAPSERVER_FILE}"

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

download_county_aerial()
{
	BASE_FILENAME=$1
	DEST_BASE_NAME=$2

	JPG_DEST_FILENAME="${JPG_DEST_DIR}"/"${DEST_BASE_NAME}".jpg
	MRSID_DEST_FILENAME="${MRSID_DEST_DIR}"/"${DEST_BASE_NAME}".sid
	MRSID_WORLD_DEST_FILENAME="${MRSID_DEST_DIR}"/"${DEST_BASE_NAME}".sdw

	append_to_mapserver_file "${JPG_MAPSERVER_FILE}" "${DEST_BASE_NAME}" "${JPG_DEST_FILENAME}"
	if [ "${KEEP_MRSID_FILES}" != "0" ] ; then
		append_to_mapserver_file "${MRSID_MAPSERVER_FILE}" "${DEST_BASE_NAME}" "${MRSID_DEST_FILENAME}"
	fi

	if [ -f "${JPG_DEST_FILENAME}" ] ; then
		echo "${JPG_DEST_FILENAME} already exists"
		return
	fi

	download_file "${BASE_URL}"/"${BASE_FILENAME}".sid "${MRSID_DEST_FILENAME}"
	download_file "${BASE_URL}"/"${BASE_FILENAME}".sdw "${MRSID_WORLD_DEST_FILENAME}"

	echo "Transforming MrSID file ${MRSID_DEST_FILENAME} into ${JPG_DEST_FILENAME}"
	"${MRSID_DECODE_BINARY}" -i "${MRSID_DEST_FILENAME}" -o "${JPG_DEST_FILENAME}" -wf

	if [ "${KEEP_MRSID_FILES}" = "0" ] ; then
		echo "Removing MrSID file ${MRSID_DEST_FILENAME}"
		rm -f "${MRSID_DEST_FILENAME}" "${MRSID_WORLD_DEST_FILENAME}"
	fi
}

#download_county_aerial Barbour/ortho_1-1_1n_s_wv001_2014_1 barbour
#download_county_aerial Berkeley/ortho_1-1_1n_s_wv003_2014_1 berkeley
#download_county_aerial Grant/ortho_1-1_1n_s_wv023_2014_1 grant
#download_county_aerial Greenbrier/ortho_1-1_1n_s_wv025_2014_1 greenbrier
#download_county_aerial Hampshire/ortho_1-1_1n_s_wv027_2014_1 hampshire
#download_county_aerial Hardy/ortho_1-1_1n_s_wv031_2014_1 hardy
#download_county_aerial Jefferson/ortho_1-1_1n_s_wv037_2014_1 jefferson
#download_county_aerial Mercer/ortho_1-1_1n_s_wv055_2014_1 mercer
#download_county_aerial Mineral/ortho_1-1_1n_s_wv057_2014_1 mineral
download_county_aerial Monongalia/ortho_1-1_1n_s_wv061_2014_1 monongalia
#download_county_aerial Monroe/ortho_1-1_1n_s_wv063_2014_1 monroe
#download_county_aerial Morgan/ortho_1-1_1n_s_wv065_2014_1 morgan
#download_county_aerial Pendleton/ortho_1-1_1n_s_wv071_2014_1 pendleton
#download_county_aerial Pocahontas/ortho_1-1_1n_s_wv075_2014_1 pocahontas
download_county_aerial Preston/ortho_1-1_1n_s_wv077_2014_1 preston
#download_county_aerial Summers/ortho_1-1_1n_s_wv089_2014_1 summers
download_county_aerial Tucker/ortho_1-1_1n_s_wv093_2014_1 tucker
