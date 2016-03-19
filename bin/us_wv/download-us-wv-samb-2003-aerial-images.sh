#!/bin/bash

# download-us-wv-samb-2003-aerial-images.sh
#
# This script downloads the SAMB 2003 aerial imagery for parts of West
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

MRSID_DECODE_BINARY=${1:-}
KEEP_MRSID_FILES=${2:-}

if [ "${MRSID_DECODE_BINARY}" = "" ] || [ ! -x "${MRSID_DECODE_BINARY}" ] ; then
	echo "usage: $0 <path to mrsiddecode binary> <keep mrsid files (0|1)>" >&2
	exit 1
fi

BASE_URL="ftp://ftp.wvgis.wvu.edu/pub/Clearinghouse/imagerybasemaps/orthophotos_SAMB_2003/UTM83/utm83zone17n/QQuad_mrsids/"

BASE_DIR=$(dirname "$0")/../..
. "${BASE_DIR}"/bin/gis-common

MRSID_DEST_DIR="${BASE_DIR}"/download/us_wv/aerial/SAMB-2003/MrSID
JPG_DEST_DIR="${BASE_DIR}"/download/us_wv/aerial/SAMB-2003/JPG
JPG_MAPSERVER_FILE="${BASE_DIR}"/download/us_wv/aerial/SAMB-2003/JPG/2003.map

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

download_aerial()
{
	BASE_FILENAME=$1

	JPG_FILENAME="${JPG_DEST_DIR}"/"${BASE_FILENAME}".jpg
        append_to_mapserver_file "${JPG_MAPSERVER_FILE}" "${BASE_FILENAME}" "${JPG_FILENAME}"

	if [ -f "${JPG_FILENAME}" ] ; then
                echo "JPG file ${JPG_FILENAME} already exists"
		return
	fi

	MRSID_URL="${BASE_URL}"/"${BASE_FILENAME}".zip
	MRSID_FILENAME="${MRSID_DEST_DIR}"/"${BASE_FILENAME}".sid
	if [ ! -f "${MRSID_FILENAME}" ] ; then
		TMP=$(mktemp --suffix=.zip)
		wget -O "${TMP}" "${MRSID_URL}"
		unzip "${TMP}" -d "${MRSID_DEST_DIR}"
		rm -f "${TMP}"
	else
		echo ""
                echo "Skipping the download of ${MRSID_URL} since ${MRSID_FILENAME} already exists."
	fi

	"${MRSID_DECODE_BINARY}" -i "${MRSID_FILENAME}" -o "${JPG_FILENAME}" -wf

	if [ "${KEEP_MRSID_FILES}" = "0" ] ; then
		echo "Removing MrSID files ${MRSID_DEST_DIR}/${BASE_FILENAME}.{aux,sdw,sid,txt}"
		rm -f "${MRSID_DEST_DIR}"/"${BASE_FILENAME}".{aux,sdw,sid,txt}
	fi
}


download_aerial adolph_ne
download_aerial adolph_nw
download_aerial adolph_se
download_aerial adolph_sw
download_aerial alderson_ne
download_aerial alderson_nw
download_aerial alderson_se
download_aerial alderson_sw
download_aerial alleghany_nw
download_aerial alleghany_sw
download_aerial alvon_ne
download_aerial alvon_nw
download_aerial alvon_se
download_aerial alvon_sw
download_aerial anthony_ne
download_aerial anthony_nw
download_aerial anthony_se
download_aerial anthony_sw
download_aerial antioch_ne
download_aerial antioch_nw
download_aerial antioch_se
download_aerial antioch_sw
download_aerial asbury_ne
download_aerial asbury_nw
download_aerial asbury_se
download_aerial asbury_sw
download_aerial aurora_ne
download_aerial aurora_nw
download_aerial aurora_se
download_aerial aurora_sw
download_aerial baker_ne
download_aerial baker_nw
download_aerial baker_se
download_aerial baker_sw
download_aerial bastian_ne
download_aerial bastian_nw
download_aerial bergton_ne
download_aerial bergton_nw
download_aerial bergton_se
download_aerial bergton_sw
download_aerial berryville_ne
download_aerial berryville_nw
download_aerial berryville_se
download_aerial berryville_sw
download_aerial beverly_east_ne
download_aerial beverly_east_nw
download_aerial beverly_east_se
download_aerial beverly_east_sw
download_aerial beverly_west_ne
download_aerial beverly_west_nw
download_aerial beverly_west_se
download_aerial beverly_west_sw
download_aerial big_pool_ne
download_aerial big_pool_nw
download_aerial big_pool_se
download_aerial big_pool_sw
download_aerial blackbird_knob_ne
download_aerial blackbird_knob_nw
download_aerial blackbird_knob_se
download_aerial blackbird_knob_sw
download_aerial blackwater_falls_ne
download_aerial blackwater_falls_nw
download_aerial blackwater_falls_se
download_aerial blackwater_falls_sw
download_aerial bluefield_ne
download_aerial bluefield_nw
download_aerial bluefield_se
download_aerial bluefield_sw
download_aerial bowden_ne
download_aerial bowden_nw
download_aerial bowden_se
download_aerial bowden_sw
download_aerial bramwell_ne
download_aerial bramwell_nw
download_aerial bramwell_se
download_aerial bramwell_sw
download_aerial bruceton_mills_ne
download_aerial bruceton_mills_nw
download_aerial bruceton_mills_se
download_aerial bruceton_mills_sw
download_aerial burlington_ne
download_aerial burlington_nw
download_aerial burlington_se
download_aerial burlington_sw
download_aerial capon_bridge_ne
download_aerial capon_bridge_nw
download_aerial capon_bridge_se
download_aerial capon_bridge_sw
download_aerial capon_springs_ne
download_aerial capon_springs_nw
download_aerial capon_springs_se
download_aerial capon_springs_sw
download_aerial cass_ne
download_aerial cass_nw
download_aerial cass_se
download_aerial cass_sw
download_aerial charles_town_ne
download_aerial charles_town_nw
download_aerial charles_town_se
download_aerial charles_town_sw
download_aerial circleville_ne
download_aerial circleville_nw
download_aerial circleville_se
download_aerial circleville_sw
download_aerial clover_lick_ne
download_aerial clover_lick_nw
download_aerial clover_lick_se
download_aerial clover_lick_sw
download_aerial colebank_ne
download_aerial colebank_nw
download_aerial colebank_se
download_aerial colebank_sw
download_aerial cornstalk_ne
download_aerial cornstalk_nw
download_aerial cornstalk_se
download_aerial cornstalk_sw
download_aerial cresaptown_ne
download_aerial cresaptown_nw
download_aerial cresaptown_se
download_aerial cresaptown_sw
download_aerial cumberland_se
download_aerial cumberland_sw
download_aerial cuzzart_ne
download_aerial cuzzart_nw
download_aerial cuzzart_se
download_aerial cuzzart_sw
download_aerial davis_ne
download_aerial davis_nw
download_aerial davis_se
download_aerial davis_sw
download_aerial dawson_ne
download_aerial dawson_nw
download_aerial dawson_se
download_aerial dawson_sw
download_aerial denmar_ne
download_aerial denmar_nw
download_aerial denmar_se
download_aerial denmar_sw
download_aerial doe_hill_ne
download_aerial doe_hill_nw
download_aerial doe_hill_se
download_aerial doe_hill_sw
download_aerial droop_ne
download_aerial droop_nw
download_aerial droop_se
download_aerial droop_sw
download_aerial durbin_ne
download_aerial durbin_nw
download_aerial durbin_se
download_aerial durbin_sw
download_aerial edray_ne
download_aerial edray_nw
download_aerial edray_se
download_aerial edray_sw
download_aerial elkins_ne
download_aerial elkins_nw
download_aerial elkins_se
download_aerial elkins_sw
download_aerial fellowsville_ne
download_aerial fellowsville_nw
download_aerial fellowsville_se
download_aerial fellowsville_sw
download_aerial fort_seybert_ne
download_aerial fort_seybert_nw
download_aerial fort_seybert_se
download_aerial fort_seybert_sw
download_aerial fort_spring_ne
download_aerial fort_spring_nw
download_aerial fort_spring_se
download_aerial fort_spring_sw
download_aerial franklin_ne
download_aerial franklin_nw
download_aerial franklin_se
download_aerial franklin_sw
download_aerial gap_mills_ne
download_aerial gap_mills_nw
download_aerial gap_mills_se
download_aerial gap_mills_sw
download_aerial glace_ne
download_aerial glace_nw
download_aerial glace_se
download_aerial glace_sw
download_aerial glady_ne
download_aerial glady_nw
download_aerial glady_se
download_aerial glady_sw
download_aerial glengary_ne
download_aerial glengary_nw
download_aerial glengary_se
download_aerial glengary_sw
download_aerial gore_ne
download_aerial gore_nw
download_aerial gore_sw
download_aerial great_cacapon_ne
download_aerial great_cacapon_nw
download_aerial great_cacapon_se
download_aerial great_cacapon_sw
download_aerial green_bank_ne
download_aerial green_bank_nw
download_aerial green_bank_se
download_aerial green_bank_sw
download_aerial greenland_gap_ne
download_aerial greenland_gap_nw
download_aerial greenland_gap_se
download_aerial greenland_gap_sw
download_aerial greenville_ne
download_aerial greenville_nw
download_aerial greenville_se
download_aerial greenville_sw
download_aerial hancock_ne
download_aerial hancock_nw
download_aerial hancock_se
download_aerial hancock_sw
download_aerial hanging_rock_ne
download_aerial hanging_rock_nw
download_aerial hanging_rock_se
download_aerial hanging_rock_sw
download_aerial harman_ne
download_aerial harman_nw
download_aerial harman_se
download_aerial harman_sw
download_aerial harpers_ferry_ne
download_aerial harpers_ferry_nw
download_aerial harpers_ferry_sw
download_aerial hedgesville_ne
download_aerial hedgesville_nw
download_aerial hedgesville_se
download_aerial hedgesville_sw
download_aerial hillsboro_ne
download_aerial hillsboro_nw
download_aerial hillsboro_se
download_aerial hillsboro_sw
download_aerial hopeville_ne
download_aerial hopeville_nw
download_aerial hopeville_se
download_aerial hopeville_sw
download_aerial interior_ne
download_aerial interior_nw
download_aerial interior_se
download_aerial interior_sw
download_aerial inwood_ne
download_aerial inwood_nw
download_aerial inwood_se
download_aerial inwood_sw
download_aerial junior_ne
download_aerial junior_nw
download_aerial junior_se
download_aerial junior_sw
download_aerial keedysville_nw
download_aerial keedysville_sw
download_aerial keyser_ne
download_aerial keyser_nw
download_aerial keyser_se
download_aerial keyser_sw
download_aerial kingwood_ne
download_aerial kingwood_nw
download_aerial kingwood_se
download_aerial kingwood_sw
download_aerial lake_lynn_ne
download_aerial lake_lynn_nw
download_aerial lake_lynn_se
download_aerial lake_lynn_sw
download_aerial lake_sherwood_ne
download_aerial lake_sherwood_nw
download_aerial lake_sherwood_se
download_aerial lake_sherwood_sw
download_aerial laneville_ne
download_aerial laneville_nw
download_aerial laneville_se
download_aerial laneville_sw
download_aerial largent_ne
download_aerial largent_nw
download_aerial largent_se
download_aerial largent_sw
download_aerial lead_mine_ne
download_aerial lead_mine_nw
download_aerial lead_mine_se
download_aerial lead_mine_sw
download_aerial lewisburg_ne
download_aerial lewisburg_nw
download_aerial lewisburg_se
download_aerial lewisburg_sw
download_aerial lindside_ne
download_aerial lindside_nw
download_aerial lindside_se
download_aerial lindside_sw
download_aerial lobelia_ne
download_aerial lobelia_nw
download_aerial lobelia_se
download_aerial lobelia_sw
download_aerial lonaconing_ne
download_aerial lonaconing_se
download_aerial lost_city_ne
download_aerial lost_city_nw
download_aerial lost_city_se
download_aerial lost_city_sw
download_aerial lost_river_state_park_ne
download_aerial lost_river_state_park_nw
download_aerial lost_river_state_park_se
download_aerial lost_river_state_park_sw
download_aerial marlinton_ne
download_aerial marlinton_nw
download_aerial marlinton_se
download_aerial marlinton_sw
download_aerial martinsburg_ne
download_aerial martinsburg_nw
download_aerial martinsburg_se
download_aerial martinsburg_sw
download_aerial masontown_ne
download_aerial masontown_nw
download_aerial masontown_se
download_aerial masontown_sw
download_aerial maysville_ne
download_aerial maysville_nw
download_aerial maysville_se
download_aerial maysville_sw
download_aerial medley_ne
download_aerial medley_nw
download_aerial medley_se
download_aerial medley_sw
download_aerial middleway_ne
download_aerial middleway_nw
download_aerial middleway_se
download_aerial middleway_sw
download_aerial milam_ne
download_aerial milam_nw
download_aerial milam_se
download_aerial milam_sw
download_aerial mill_creek_ne
download_aerial mill_creek_nw
download_aerial mill_creek_se
download_aerial mill_creek_sw
download_aerial mingo_ne
download_aerial mingo_nw
download_aerial mingo_se
download_aerial mingo_sw
download_aerial minnehaha_springs_ne
download_aerial minnehaha_springs_nw
download_aerial minnehaha_springs_se
download_aerial minnehaha_springs_sw
download_aerial moatstown_ne
download_aerial moatstown_nw
download_aerial moatstown_se
download_aerial moatstown_sw
download_aerial montrose_ne
download_aerial montrose_nw
download_aerial montrose_se
download_aerial montrose_sw
download_aerial mountain_falls_ne
download_aerial mountain_falls_nw
download_aerial mount_storm_ne
download_aerial mount_storm_nw
download_aerial mount_storm_se
download_aerial mount_storm_sw
download_aerial mount_storm_lake_ne
download_aerial mount_storm_lake_nw
download_aerial mount_storm_lake_se
download_aerial mount_storm_lake_sw
download_aerial mozark_mountain_ne
download_aerial mozark_mountain_nw
download_aerial mozark_mountain_se
download_aerial mozark_mountain_sw
download_aerial mozer_ne
download_aerial mozer_nw
download_aerial mozer_se
download_aerial mozer_sw
download_aerial narrows_ne
download_aerial narrows_nw
download_aerial narrows_sw
download_aerial needmore_ne
download_aerial needmore_nw
download_aerial needmore_se
download_aerial needmore_sw
download_aerial oakland_nw
download_aerial oakland_sw
download_aerial oakvale_ne
download_aerial oakvale_nw
download_aerial oakvale_se
download_aerial oakvale_sw
download_aerial old_fields_ne
download_aerial old_fields_nw
download_aerial old_fields_se
download_aerial old_fields_sw
download_aerial onego_ne
download_aerial onego_nw
download_aerial onego_se
download_aerial onego_sw
download_aerial orkney_springs_ne
download_aerial orkney_springs_nw
download_aerial orkney_springs_se
download_aerial orkney_springs_sw
download_aerial paddy_knob_ne
download_aerial paddy_knob_nw
download_aerial paddy_knob_se
download_aerial paddy_knob_sw
download_aerial paint_bank_ne
download_aerial paint_bank_nw
download_aerial paint_bank_se
download_aerial paint_bank_sw
download_aerial palo_alto_ne
download_aerial palo_alto_nw
download_aerial palo_alto_se
download_aerial palo_alto_sw
download_aerial parsons_ne
download_aerial parsons_nw
download_aerial parsons_se
download_aerial parsons_sw
download_aerial patterson_creek_ne
download_aerial patterson_creek_nw
download_aerial patterson_creek_se
download_aerial patterson_creek_sw
download_aerial petersburg_east_ne
download_aerial petersburg_east_nw
download_aerial petersburg_east_se
download_aerial petersburg_east_sw
download_aerial petersburg_west_ne
download_aerial petersburg_west_nw
download_aerial petersburg_west_se
download_aerial petersburg_west_sw
download_aerial peterstown_ne
download_aerial peterstown_nw
download_aerial peterstown_se
download_aerial peterstown_sw
download_aerial potts_creek_nw
download_aerial princeton_ne
download_aerial princeton_nw
download_aerial princeton_se
download_aerial princeton_sw
download_aerial ridge_ne
download_aerial ridge_nw
download_aerial ridge_se
download_aerial ridge_sw
download_aerial rig_ne
download_aerial rig_nw
download_aerial rig_se
download_aerial rig_sw
download_aerial rio_ne
download_aerial rio_nw
download_aerial rio_se
download_aerial rio_sw
download_aerial romney_ne
download_aerial romney_nw
download_aerial romney_se
download_aerial romney_sw
download_aerial ronceverte_ne
download_aerial ronceverte_nw
download_aerial ronceverte_se
download_aerial ronceverte_sw
download_aerial round_hill_ne
download_aerial round_hill_nw
download_aerial round_hill_se
download_aerial round_hill_sw
download_aerial rowlesburg_ne
download_aerial rowlesburg_nw
download_aerial rowlesburg_se
download_aerial rowlesburg_sw
download_aerial saint_george_ne
download_aerial saint_george_nw
download_aerial saint_george_se
download_aerial saint_george_sw
download_aerial samp_ne
download_aerial samp_nw
download_aerial samp_se
download_aerial samp_sw
download_aerial sang_run_nw
download_aerial sang_run_sw
download_aerial sector_ne
download_aerial sector_nw
download_aerial sector_se
download_aerial sector_sw
download_aerial sharp_knob_ne
download_aerial sharp_knob_nw
download_aerial sharp_knob_se
download_aerial sharp_knob_sw
download_aerial shepherdstown_ne
download_aerial shepherdstown_nw
download_aerial shepherdstown_se
download_aerial shepherdstown_sw
download_aerial sinks_of_gandy_ne
download_aerial sinks_of_gandy_nw
download_aerial sinks_of_gandy_se
download_aerial sinks_of_gandy_sw
download_aerial snowy_mountain_ne
download_aerial snowy_mountain_nw
download_aerial snowy_mountain_se
download_aerial snowy_mountain_sw
download_aerial snyder_knob_ne
download_aerial snyder_knob_nw
download_aerial snyder_knob_se
download_aerial snyder_knob_sw
download_aerial springfield_ne
download_aerial springfield_nw
download_aerial springfield_se
download_aerial springfield_sw
download_aerial spruce_knob_ne
download_aerial spruce_knob_nw
download_aerial spruce_knob_se
download_aerial spruce_knob_sw
download_aerial stephenson_ne
download_aerial stotlers_crossroads_ne
download_aerial stotlers_crossroads_nw
download_aerial stotlers_crossroads_se
download_aerial stotlers_crossroads_sw
download_aerial sugar_grove_ne
download_aerial sugar_grove_nw
download_aerial sugar_grove_se
download_aerial sugar_grove_sw
download_aerial table_rock_nw
download_aerial table_rock_se
download_aerial table_rock_sw
download_aerial tablers_station_ne
download_aerial tablers_station_nw
download_aerial tablers_station_se
download_aerial tablers_station_sw
download_aerial talcott_ne
download_aerial talcott_nw
download_aerial talcott_se
download_aerial talcott_sw
download_aerial terra_alta_ne
download_aerial terra_alta_nw
download_aerial terra_alta_se
download_aerial terra_alta_sw
download_aerial trout_ne
download_aerial trout_nw
download_aerial trout_se
download_aerial trout_sw
download_aerial union_ne
download_aerial union_nw
download_aerial union_se
download_aerial union_sw
download_aerial upper_tract_ne
download_aerial upper_tract_nw
download_aerial upper_tract_se
download_aerial upper_tract_sw
download_aerial valley_head_ne
download_aerial valley_head_nw
download_aerial valley_head_se
download_aerial valley_head_sw
download_aerial valley_point_ne
download_aerial valley_point_nw
download_aerial valley_point_se
download_aerial valley_point_sw
download_aerial waiteville_ne
download_aerial waiteville_nw
download_aerial waiteville_se
download_aerial waiteville_sw
download_aerial wardensville_ne
download_aerial wardensville_nw
download_aerial wardensville_se
download_aerial wardensville_sw
download_aerial webster_springs_ne
download_aerial webster_springs_nw
download_aerial webster_springs_se
download_aerial webster_springs_sw
download_aerial westernport_ne
download_aerial westernport_nw
download_aerial westernport_se
download_aerial westernport_sw
download_aerial white_hall_ne
download_aerial white_hall_nw
download_aerial white_hall_se
download_aerial white_hall_sw
download_aerial white_sulphur_springs_ne
download_aerial white_sulphur_springs_nw
download_aerial white_sulphur_springs_se
download_aerial white_sulphur_springs_sw
download_aerial whitmer_ne
download_aerial whitmer_nw
download_aerial whitmer_se
download_aerial whitmer_sw
download_aerial wildell_ne
download_aerial wildell_nw
download_aerial wildell_se
download_aerial wildell_sw
download_aerial williamsburg_ne
download_aerial williamsburg_nw
download_aerial williamsburg_se
download_aerial williamsburg_sw
download_aerial williamsport_nw
download_aerial williamsport_se
download_aerial williamsport_sw
download_aerial wolf_gap_ne
download_aerial wolf_gap_nw
download_aerial wolf_gap_se
download_aerial wolf_gap_sw
download_aerial woodrow_ne
download_aerial woodrow_nw
download_aerial woodrow_se
download_aerial woodrow_sw
download_aerial yellow_spring_ne
download_aerial yellow_spring_nw
download_aerial yellow_spring_se
download_aerial yellow_spring_sw