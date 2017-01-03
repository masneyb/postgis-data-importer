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

BASE_URL="ftp://ftp.wvgis.wvu.edu/pub/Clearinghouse/imagerybasemaps/24kDRG_USGS/NAD83/no_collar/"

BASE_DIR=$(dirname "$0")/../..
. "${BASE_DIR}"/bin/gis-common

DEST_DIR="${BASE_DIR}"/download/us_wv/aerial/USGS-1994/
MAPSERVER_FILE="${DEST_DIR}"/usgs_1994.map

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

download_topo()
{
	ZIP_FILENAME=$1
	BASE_FILENAME=$2

	URL="${BASE_URL}"/"${ZIP_FILENAME}"
	DEST_FILE="${DEST_DIR}"/"${BASE_FILENAME}".tif

        append_to_mapserver_file "${BASE_FILENAME}" "${DEST_FILE}"

	if [ -f "${DEST_FILE}" ] ; then
                echo "File ${DEST_FILE} already exists"
		return
	fi

	TMP=$(mktemp --suffix=.zip)
	echo "Downloading ${URL} to ${TMP}"
	wget -O "${TMP}" "${URL}"

        TMPDIR=$(mktemp -d)
        unzip -qq "${TMP}" -d "${TMPDIR}"
	mv "${TMPDIR}"/*.tif "${DEST_FILE}"
	rm -rf "${TMPDIR}" "${TMP}"
}

download_topo adolph_USGS_1994_utm83_tif.zip adolph
download_topo alderson_USGS_1994_utm83_tif.zip alderson
download_topo alleghany_USGS_1994_utm83_tif.zip alleghany
download_topo alvon_USGS_1994_utm83_tif.zip alvon
download_topo anthony_USGS_1994_utm83_tif.zip anthony
download_topo antioch_USGS_1994_utm83_tif.zip antioch
download_topo asbury_USGS_1994_utm83_tif.zip asbury
download_topo aurora_USGS_1994_utm83_tif.zip aurora
download_topo baker_USGS_1994_utm83_tif.zip baker
download_topo bastian_USGS_1994_utm83_tif.zip bastian
download_topo bergton_USGS_1994_utm83_tif.zip bergton
download_topo berryville_USGS_1994_utm83_tif.zip berryville
download_topo beverly_east_USGS_1994_utm83_tif.zip beverly_east
download_topo beverly_west_USGS_1994_utm83_tif.zip beverly_west
download_topo big_pool_USGS_1994_utm83_tif.zip big_pool
download_topo blackbird_knob_USGS_1994_utm83_tif.zip blackbird_knob
download_topo blackwater_falls_USGS_1994_utm83_tif.zip blackwater_falls
download_topo bluefield_USGS_1994_utm83_tif.zip bluefield
download_topo bowden_USGS_1994_utm83_tif.zip bowden
download_topo bramwell_USGS_1994_utm83_tif.zip bramwell
download_topo bruceton_mills_USGS_1994_utm83_tif.zip bruceton_mills
download_topo burlington_USGS_1994_utm83_tif.zip burlington
download_topo capon_bridge_USGS_1994_utm83_tif.zip capon_bridge
download_topo capon_springs_USGS_1994_utm83_tif.zip capon_springs
download_topo cass_USGS_1994_utm83_tif.zip cass
download_topo charles_town_USGS_1994_utm83_tif.zip charles_town
download_topo circleville_USGS_1994_utm83_tif.zip circleville
download_topo clover_lick_USGS_1994_utm83_tif.zip clover_lick
download_topo colebank_USGS_1994_utm83_tif.zip colebank
download_topo cornstalk_USGS_1994_utm83_tif.zip cornstalk
download_topo cresaptown_USGS_1994_utm83_tif.zip cresaptown
download_topo cumberland_USGS_1994_utm83_tif.zip cumberland
download_topo cuzzart_USGS_1994_utm83_tif.zip cuzzart
download_topo davis_USGS_1994_utm83_tif.zip davis
download_topo dawson_USGS_1994_utm83_tif.zip dawson
download_topo denmar_USGS_1994_utm83_tif.zip denmar
download_topo doe_hill_USGS_1994_utm83_tif.zip doe_hill
download_topo droop_USGS_1994_utm83_tif.zip droop
download_topo durbin_USGS_1994_utm83_tif.zip durbin
download_topo edray_USGS_1994_utm83_tif_USGS_1994_utm83_tif.zip edray
download_topo elkins_USGS_1994_utm83_tif.zip elkins
download_topo fellowsville_USGS_1994_utm83_tif.zip fellowsville
download_topo fort_seybert_USGS_1994_utm83_tif.zip fort_seybert
download_topo fort_spring_USGS_1994_utm83_tif.zip fort_spring
download_topo franklin_USGS_1994_utm83_tif.zip franklin
download_topo gap_mills_USGS_1994_utm83_tif.zip gap_mills
download_topo glace_USGS_1994_utm83_tif.zip glace
download_topo glady_USGS_1994_utm83_tif.zip glady
download_topo glengary_USGS_1994_utm83_tif.zip glengary
download_topo gore_USGS_1994_utm83_tif.zip gore
download_topo great_cacapon_USGS_1994_utm83_tif.zip great_cacapon
download_topo green_bank_USGS_1994_utm83_tif.zip green_bank
download_topo greenland_gap_USGS_1994_utm83_tif.zip greenland_gap
download_topo greenville_USGS_1994_utm83_tif.zip greenville
download_topo hancock_USGS_1994_utm83_tif.zip hancock
download_topo hanging_rock_USGS_1994_utm83_tif.zip hanging_rock
download_topo harman_USGS_1994_utm83_tif.zip harman
download_topo harpers_ferry_USGS_1994_utm83_tif.zip harpers_ferry
download_topo hedgesville_USGS_1994_utm83_tif.zip hedgesville
download_topo hillsboro_USGS_1994_utm83_tif.zip hillsboro
download_topo hopeville_USGS_1994_utm83_tif.zip hopeville
download_topo interior_USGS_1994_utm83_tif.zip interior
download_topo inwood_USGS_1994_utm83_tif.zip inwood
download_topo junior_USGS_1994_utm83_tif.zip junior
download_topo keedysville_USGS_1994_utm83_tif.zip keedysville
download_topo keyser_USGS_1994_utm83_tif.zip keyser
download_topo kingwood_USGS_1994_utm83_tif.zip kingwood
download_topo lake_lynn_USGS_1994_utm83_tif.zip lake_lynn
download_topo lake_sherwood_USGS_1994_utm83_tif.zip lake_sherwood
download_topo laneville_USGS_1994_utm83_tif.zip laneville
download_topo largent_USGS_1994_utm83_tif.zip largent
download_topo lead_mine_USGS_1994_utm83_tif.zip lead_mine
download_topo lewisburg_USGS_1994_utm83_tif.zip lewisburg
download_topo lindside_USGS_1994_utm83_tif.zip lindside
download_topo lobelia_USGS_1994_utm83_tif.zip lobelia
download_topo lost_city_USGS_1994_utm83_tif.zip lost_city
download_topo lost_river_state_park_USGS_1994_utm83_tif.zip lost_river_state_park
download_topo marlinton_USGS_1994_utm83_tif.zip marlinton
download_topo martinsburg_USGS_1994_utm83_tif.zip martinsburg
download_topo masontown_USGS_1994_utm83_tif.zip masontown
download_topo maysville_USGS_1994_utm83_tif.zip maysville
download_topo medley_USGS_1994_utm83_tif.zip medley
download_topo middleway_USGS_1994_utm83_tif.zip middleway
download_topo milam_USGS_1994_utm83_tif.zip milam
download_topo mill_creek_USGS_1994_utm83_tif.zip mill_creek
download_topo mingo_USGS_1994_utm83_tif.zip mingo
download_topo minnehaha_springs_USGS_1994_utm83_tif.zip minnehaha_springs
download_topo moatstown_USGS_1994_utm83_tif.zip moatstown
download_topo montrose_USGS_1994_utm83_tif.zip montrose
download_topo mountain_falls_USGS_1994_utm83_tif.zip mountain_falls
download_topo mount_storm_lake_USGS_1994_utm83_tif.zip mount_storm_lake
download_topo mount_storm_USGS_1994_utm83_tif.zip mount_storm
download_topo mount_storm_lake_USGS_1994_utm83_tif.zip mount_storm_lake
download_topo mozark_mountain_USGS_1994_utm83_tif.zip mozark_mountain
download_topo mozer_USGS_1994_utm83_tif.zip mozer
download_topo narrows_USGS_1994_utm83_tif.zip narrows
download_topo needmore_USGS_1994_utm83_tif.zip needmore
download_topo oakland_USGS_1994_utm83_tif.zip oakland
download_topo oakvale_USGS_1994_utm83_tif.zip oakvale
download_topo old_fields_USGS_1994_utm83_tif.zip old_fields
download_topo onego_USGS_1994_utm83_tif.zip onego
download_topo orkney_springs_USGS_1994_utm83_tif.zip orkney_springs
download_topo paddy_knob_USGS_1994_utm83_tif.zip paddy_knob
download_topo paint_bank_USGS_1994_utm83_tif.zip paint_bank
download_topo palo_alto_USGS_1994_utm83_tif.zip palo_alto
download_topo parsons_USGS_1994_utm83_tif.zip parsons
download_topo patterson_creek_USGS_1994_utm83_tif.zip patterson_creek
download_topo petersburg_east_USGS_1994_utm83_tif.zip petersburg_east
download_topo petersburg_west_USGS_1994_utm83_tif.zip petersburg_west
download_topo peterstown_USGS_1994_utm83_tif.zip peterstown
download_topo potts_creek_USGS_1994_utm83_tif.zip potts_creek
download_topo princeton_USGS_1994_utm83_tif.zip princeton
download_topo ridge_USGS_1994_utm83_tif.zip ridge
download_topo rig_USGS_1994_utm83_tif.zip rig
download_topo rio_USGS_1994_utm83_tif.zip rio
download_topo romney_USGS_1994_utm83_tif.zip romney
download_topo ronceverte_USGS_1994_utm83_tif.zip ronceverte
download_topo round_hill_USGS_1994_utm83_tif.zip round_hill
download_topo rowlesburg_USGS_1994_utm83_tif.zip rowlesburg
download_topo saint_george_USGS_1994_utm83_tif_USGS_1994_utm83_tif.zip saint_george
download_topo samp_USGS_1994_utm83_tif.zip samp
download_topo sang_run_USGS_1994_utm83_tif.zip sang_run
download_topo sector_USGS_1994_utm83_tif.zip sector
download_topo sharp_knob_USGS_1994_utm83_tif.zip sharp_knob
download_topo shepherdstown_USGS_1994_utm83_tif.zip shepherdstown
download_topo sinks_of_gandy_USGS_1994_utm83_tif.zip sinks_of_gandy
download_topo snowy_mountain_USGS_1994_utm83_tif.zip snowy_mountain
download_topo snyder_knob_USGS_1994_utm83_tif.zip snyder_knob
download_topo springfield_USGS_1994_utm83_tif.zip springfield
download_topo spruce_knob_USGS_1994_utm83_tif.zip spruce_knob
download_topo stephenson_USGS_1994_utm83_tif.zip stephenson
download_topo stotlers_crossroads_USGS_1994_utm83_tif.zip stotlers_crossroads
download_topo sugar_grove_USGS_1994_utm83_tif.zip sugar_grove
download_topo table_rock_USGS_1994_utm83_tif.zip table_rock
download_topo tablers_station_USGS_1994_utm83_tif.zip tablers_station
download_topo talcott_USGS_1994_utm83_tif.zip talcott
download_topo terra_alta_USGS_1994_utm83_tif.zip terra_alta
download_topo trout_USGS_1994_utm83_tif.zip trout
download_topo union_USGS_1994_utm83_tif.zip unionwv
download_topo upper_tract_USGS_1994_utm83_tif.zip upper_tract
download_topo valley_head_USGS_1994_utm83_tif.zip valley_head
download_topo valley_point_USGS_1994_utm83_tif.zip valley_point
download_topo waiteville_USGS_1994_utm83_tif.zip waiteville
download_topo wardensville_USGS_1994_utm83_tif.zip wardensville
download_topo webster_springs_se_USGS_1994_utm83_tif.zip webster_springs_se
download_topo webster_springs_sw_USGS_1994_utm83_tif.zip webster_springs_sw
download_topo webster_springs_USGS_1994_utm83_tif.zip webster_springs
download_topo westernport_USGS_1994_utm83_tif.zip westernport
download_topo white_hall_USGS_1994_utm83_tif.zip white_hall
download_topo white_sulphur_springs_USGS_1994_utm83_tif.zip white_sulphur_springs
download_topo whitmer_USGS_1994_utm83_tif.zip whitmer
download_topo wildell_USGS_1994_utm83_tif.zip wildell
download_topo williamsburg_USGS_1994_utm83_tif.zip williamsburg
download_topo williamsport_USGS_1994_utm83_tif.zip williamsport
download_topo wolf_gap_USGS_1994_utm83_tif.zip wolf_gap
download_topo woodrow_USGS_1994_utm83_tif.zip woodrow

# Include a few 7.5 quads that don't have karst

download_topo alton_USGS_1994_utm83_tif.zip alton
download_topo athens_USGS_1994_utm83_tif.zip athens
download_topo audra_USGS_1994_utm83_tif.zip audra
download_topo augusta_USGS_1994_utm83_tif.zip augusta
download_topo belington_USGS_1994_utm83_tif.zip belington
download_topo bellegrove_USGS_1994_utm83_tif.zip bellegrove
download_topo bergoo_USGS_1994_utm83_tif.zip bergoo
download_topo bethany_USGS_1994_utm83_tif.zip bethany
download_topo big_isaac_USGS_1994_utm83_tif.zip big_isaac
download_topo brandywine_USGS_1994_utm83_tif.zip brandywine
download_topo buckhannon_USGS_1994_utm83_tif.zip buckhannon
download_topo cassity_USGS_1994_utm83_tif.zip cassity
download_topo century_USGS_1994_utm83_tif.zip century
download_topo charleston_west_USGS_1994_utm83_tif.zip charleston_west
download_topo clarksburg_USGS_1994_utm83_tif.zip clarksburg
download_topo cow_knob_USGS_1994_utm83_tif.zip cow_knob
download_topo craig_springs_USGS_1994_utm83_tif.zip craig_springs
download_topo crumpler_USGS_1994_utm83_tif.zip crumpler
download_topo duo_USGS_1994_utm83_tif.zip duo
download_topo ellamore_USGS_1994_utm83_tif.zip ellamore
download_topo flat_top_USGS_1994_utm83_tif.zip flat_top
download_topo forest_hill_USGS_1994_utm83_tif.zip forest_hill
download_topo goshen_USGS_1994_utm83_tif.zip goshen
download_topo headsville_USGS_1994_utm83_tif.zip headsville
download_topo hightown_USGS_1994_utm83_tif.zip hightown
download_topo hinton_USGS_1994_utm83_tif.zip hinton
download_topo jerrys_run_USGS_1994_utm83_tif.zip jerrys_run
download_topo lerona_USGS_1994_utm83_tif.zip lerona
download_topo levels_USGS_1994_utm83_tif.zip levels
download_topo matoaka_USGS_1994_utm83_tif_USGS_1994_utm83_tif.zip matoaka
download_topo meadow_bridge_USGS_1994_utm83_tif.zip meadow_bridge
download_topo meadow_creek_USGS_1994_utm83_tif.zip meadow_creek
download_topo monterey_USGS_1994_utm83_tif.zip monterey
download_topo moorefield_USGS_1994_utm83_tif.zip moorefield
download_topo mountain_grove_USGS_1994_utm83_tif.zip mountain_grove
download_topo mount_clare_USGS_1994_utm83_tif.zip mount_clare
download_topo new_martinsville_USGS_1994_utm83_tif.zip new_martinsville
download_topo odd_USGS_1994_utm83_tif.zip odd
download_topo paden_city_USGS_1994_utm83_tif.zip paden_city
download_topo pickens_USGS_1994_utm83_tif.zip pickens
download_topo pine_grove_USGS_1994_utm83_tif.zip pine_grove
download_topo pipestem_USGS_1994_utm83_tif.zip pipestem
download_topo porters_falls_USGS_1994_utm83_tif.zip porters_falls
download_topo prince_USGS_1994_utm83_tif.zip prince
download_topo quinwood_USGS_1994_utm83_tif.zip quinwood
download_topo reddish_knob_USGS_1994_utm83_tif.zip reddish_knob
download_topo rock_cave_USGS_1994_utm83_tif.zip rock_cave
download_topo round_bottom_USGS_1994_utm83_tif.zip round_bottom
download_topo rupert_USGS_1994_utm83_tif.zip rupert
download_topo salem_USGS_1994_utm83_tif.zip salem
download_topo shady_spring_USGS_1994_utm83_tif.zip shady_spring
download_topo skelt_USGS_1994_utm83_tif.zip skelt
download_topo summersville_dam_USGS_1994_utm83_tif.zip summersville_dam
download_topo summersville_USGS_1994_utm83_tif.zip summersville
download_topo sunrise_USGS_1994_utm83_tif.zip sunrise
download_topo thornwood_USGS_1994_utm83_tif.zip thornwood
download_topo tiltonsville_USGS_1994_utm83_tif.zip tiltonsville
download_topo valley_grove_USGS_1994_utm83_tif.zip valley_grove
download_topo west_milford_USGS_1994_utm83_tif.zip west_milford
download_topo wheeling_USGS_1994_utm83_tif.zip wheeling
download_topo widen_USGS_1994_utm83_tif.zip widen
download_topo wileyville_USGS_1994_utm83_tif.zip wileyville
download_topo wolf_summit_USGS_1994_utm83_tif.zip wolf_summit
download_topo woodstock_USGS_1994_utm83_tif.zip woodstock

