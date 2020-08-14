#!/bin/bash -e

# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This script checks to make sure that the pre-requisite APIs are enabled.

function enable_api() {
  SERVICE=$1

  # echo "gcloud services list --format='value(name)' --filter='serviceConfig.name:$SERVICE' 2>&1"

  if [[ $(gcloud services list --format="value(config.name)" \
                                --filter="config.name:$SERVICE" 2>&1) != \
                                "$SERVICE" ]]; then
    echo "Enabling $SERVICE"
    gcloud services enable "$SERVICE"
  else
    echo "$SERVICE is already enabled"
  fi
}

enable_api sqladmin.googleapis.com
enable_api container.googleapis.com
enable_api iam.googleapis.com