#!/usr/bin/env bash
set -e

export toolName='freesurfer'
export toolVersion=7.1.0

source ../main_setup.sh

# export localSingularityBuild='false'
# export localSingularityBuildWritable='true'

neurodocker generate ${neurodocker_buildMode} \
   --base centos:7 \
   --pkg-manager yum \
   --run="printf '#!/bin/bash\nls -la' > /usr/bin/ll" \
   --run="chmod +x /usr/bin/ll" \
   --run="mkdir ${mountPointList}" \
   --${toolName} version=${toolVersion} \
   --copy ../../license.txt /opt/${toolName}-${toolVersion}/ \
   --env DEPLOY_PATH=/opt/${toolName}-${toolVersion}/bin/ \
   --user=neuro \
  > recipe.${imageName}

./../main_build.sh
