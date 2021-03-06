#!/bin/bash

#
# run it like this:
#  export SMAC_M_HOME=<path_to where you cloned https://github.com/LarsSchy/SMAC-M> ; \
#  export ENC_ROOT=<path to directory with ENC files> ; \
#  export OUT=<output-toml-config> ; \
#  ./convert-s57.sh
#
# Example:
#
# export SMAC_M_HOME=`pwd` ; export ENC_ROOT=~/ENC_ROOT/US5CT1GQ/ ; export OUT=my_config.toml; ./convert-s57.sh
#
#
# The result stored under ${SMAC_M_HOME}/../chart-installation/data_files_conversion/shp_s57data/shp/
# see (-enhancedchartdata argument)
#

OLD_DIR=`pwd`

cd ${SMAC_M_HOME} || exit 255

source "$(pipenv --venv)/bin/activate"

python3 ${SMAC_M_HOME}/bin/generate_toml_config.py \
     --chart ${ENC_ROOT} \
     -rule-default-color IHO \
     --chartsymbols ./chart-installation/generate_map_files/resources/chartsymbols/chartsymbols_S57.xml \
     -enhancedchartdata ../chart-installation/data_files_conversion/shp_s57data/shp \
     --tablename Paper \
     --displaycategory Standard \
     --rule-set-path ./chart-installation/generate_map_files/resources/rules \
     -o ${OUT}

python3 ${SMAC_M_HOME}/bin/generate_shapefiles.py ${OUT}

python3 ${SMAC_M_HOME}/chart-installation/generate_map_files/generate_map_config.py ${OUT}

cd ${OLD_DIR} || exit 255
