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

REL_BASE_DIR=$(dirname "$0")/../..
BASE_DIR=$(readlink -f "${REL_BASE_DIR}")
. "${BASE_DIR}"/bin/gis-common

BASE_URL="ftp://ftp.wvgis.wvu.edu/pub/Clearinghouse/elevation/3MeterDEM_SAMB_2003_utm83/tiff/zipped"
DEST_DIR="${BASE_DIR}"/download/us_wv/dem

download_dem()
{
	FILENAME=$1

	download_file "${BASE_URL}"/"${FILENAME}" "${DEST_DIR}"/"${FILENAME}"
}

# Note: This is all 7.5 minute quads that have karst. This list was found
# with the following SQL query:
#
# select distinct wv_7_5_index_grid.quad_name
#	from wv_7_5_index_grid, wv_karst
#	where st_intersects(wv_karst.geom, wv_7_5_index_grid.geom)
#	order by quad_name;

download_dem adolph_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem alderson_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem alleghany_va_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem alvon_wv_va_USGSAndSAMB_2003_utm83_tif.zip
download_dem anthony_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem antioch_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem asbury_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem aurora_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem baker_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem bastian_va_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem bergton_va_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem berryville_va_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem beverly_east_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem beverly_west_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem big_pool_md_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem blackbird_knob_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem blackwater_falls_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem bluefield_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem bowden_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem bramwell_wv_va_USGSAndSAMB_2003_utm83_tif.zip
download_dem bruceton_mills_wv_pa_USGSAndSAMB_2003_utm83_tif.zip
download_dem burlington_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem capon_bridge_wv_va_USGSAndSAMB_2003_utm83_tif.zip
download_dem capon_springs_wv_va_USGSAndSAMB_2003_utm83_tif.zip
download_dem cass_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem charles_town_wv_md_va_USGSAndSAMB_2003_utm83_tif.zip
download_dem circleville_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem clover_lick_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem colebank_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem cornstalk_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem cresaptown_md_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem cumberland_md_pa_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem cuzzart_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem davis_wv_md_USGSAndSAMB_2003_utm83_tif.zip
download_dem dawson_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem denmar_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem doe_hill_va_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem droop_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem durbin_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem edray_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem elkins_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem fellowsville_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem fort_seybert_wv_va_USGSAndSAMB_2003_utm83_tif.zip
download_dem fort_spring_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem franklin_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem gap_mills_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem glace_wv_va_USGSAndSAMB_2003_utm83_tif.zip
download_dem glady_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem glengary_wv_va_USGSAndSAMB_2003_utm83_tif.zip
download_dem gore_va_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem great_cacapon_wv_md_USGSAndSAMB_2003_utm83_tif.zip
download_dem green_bank_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem greenland_gap_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem greenville_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem hancock_md_pa_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem hanging_rock_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem harman_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem harpers_ferry_wv_md_va_USGSAndSAMB_2003_utm83_tif.zip
download_dem hedgesville_wv_md_USGSAndSAMB_2003_utm83_tif.zip
download_dem hillsboro_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem hopeville_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem interior_va_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem inwood_wv_va_USGSAndSAMB_2003_utm83_tif.zip
download_dem junior_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem keedysville_md_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem keyser_wv_md_USGSAndSAMB_2003_utm83_tif.zip
download_dem kingwood_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem lake_lynn_pa_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem lake_sherwood_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem laneville_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem largent_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem lead_mine_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem lewisburg_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem lindside_wv_va_USGSAndSAMB_2003_utm83_tif.zip
download_dem lobelia_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem lonaconing_md_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem lost_city_wv_va_USGSAndSAMB_2003_utm83_tif.zip
download_dem lost_river_state_park_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem marlinton_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem martinsburg_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem masontown_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem maysville_wv_USGSAndSAMB_2003_utm83_tif_tif.zip
download_dem medley_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem middleway_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem milam_wv_va_USGSAndSAMB_2003_utm83_tif.zip
download_dem mill_creek_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem mingo_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem minnehaha_springs_wv_va_USGSAndSAMB_2003_utm83_tif.zip
download_dem moatstown_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem montrose_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem mountain_falls_va_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem mount_storm_lake_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem mount_storm_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem mozark_mountain_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem mozer_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem narrows_va_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem needmore_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem oakland_md_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem oakvale_wv_va_USGSAndSAMB_2003_utm83_tif.zip
download_dem old_fields_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem onego_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem orkney_springs_va_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem paddy_knob_wv_va_USGSAndSAMB_2003_utm83_tif.zip
download_dem paint_bank_va_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem palo_alto_va_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem parsons_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem patterson_creek_wv_md_USGSAndSAMB_2003_utm83_tif.zip
download_dem petersburg_east_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem petersburg_west_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem peterstown_wv_va_USGSAndSAMB_2003_utm83_tif.zip
download_dem potts_creek_va_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem princeton_wv_va_USGSAndSAMB_2003_utm83_tif.zip
download_dem ridge_wv_va_USGSAndSAMB_2003_utm83_tif.zip
download_dem rig_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem rio_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem romney_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem ronceverte_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem round_hill_va_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem rowlesburg_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem saint_george_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem samp_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem sang_run_md_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem sector_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem sharp_knob_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem shepherdsown_wv_md_USGSAndSAMB_2003_utm83_tif.zip
download_dem sinks_of_gandy_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem snowy_mountain_wv_va_USGSAndSAMB_2003_utm83_tif.zip
download_dem snyder_knob_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem springfield_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem spruce_knob_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem stephenson_va_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem stotlers_crossroads_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem sugar_grove_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem table_rock_md_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem tablers_station_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem talcott_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem terra_alta_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem trout_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem union_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem upper_tract_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem valley_head_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem valley_point_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem waiteville_wv_va_USGSAndSAMB_2003_utm83_tif.zip
download_dem wardensville_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem webster_springs_se_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem webster_springs_sw_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem webster_springs_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem westernport_md_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem white_hall_va_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem white_sulphur_springs_wv_va_USGSAndSAMB_2003_utm83_tif.zip
download_dem whitmer_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem wildell_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem williamsburg_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem williamsport_md_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem wolf_gap_wv_va_USGSAndSAMB_2003_utm83_tif.zip
download_dem woodrow_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem yellow_spring_wv_USGSAndSAMB_2003_utm83_tif.zip

# Include a few 7.5 quads that don't have karst

download_dem alton_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem athens_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem audra_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem augusta_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem belington_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem bellegrove_md_pa_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem bergoo_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem bethany_wv_pa_USGSAndSAMB_2003_utm83_tif.zip
download_dem big_isaac_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem brandywine_wv_va_USGSAndSAMB_2003_utm83_tif.zip
download_dem buckhannon_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem cassity_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem century_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem charleston_west_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem clarksburg_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem cow_knob_va_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem craig_springs_va_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem crumpler_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem duo_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem ellamore_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem flat_top_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem forest_hill_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem goshen_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem headsville_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem hightown_va_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem hinton_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem jerrys_run_va_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem lerona_wv_va_USGSAndSAMB_2003_utm83_tif.zip
download_dem levels_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem matoaka_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem meadow_bridge_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem meadow_creek_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem monterey_va_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem moorefield_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem morgantown_north_wv_pa_USGSAndSAMB_2003_utm83_tif.zip
download_dem morgantown_south_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem mountain_grove_va_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem mount_clare_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem new_martinsville_wv_oh_USGSAndSAMB_2003_utm83_tif.zip
download_dem odd_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem paden_city_wv_oh_USGSAndSAMB_2003_utm83_tif.zip
download_dem pickens_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem pine_grove_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem pipestem_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem porters_falls_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem prince_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem quinwood_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem reddish_knob_va_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem rock_cave_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem round_bottom_oh_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem rupert_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem salem_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem shady_spring_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem skelt_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem summersville_dam_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem summersville_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem sunrise_va_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem thornwood_wv_va_USGSAndSAMB_2003_utm83_tif.zip
download_dem tiltonsville_oh_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem valley_grove_wv_pa_USGSAndSAMB_2003_utm83_tif.zip
download_dem west_milford_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem wheeling_wv_oh_USGSAndSAMB_2003_utm83_tif.zip
download_dem widen_wv_USGSAndSAMB_2003_tif.zip
download_dem widen_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem wileyville_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem wolf_summit_wv_USGSAndSAMB_2003_utm83_tif.zip
download_dem woodstock_va_wv_USGSAndSAMB_2003_utm83_tif.zip

