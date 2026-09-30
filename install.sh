#!/bin/bash

echo "  *********************************************************************************"
echo "  *                                                                               *"
echo "  *                        Welcome to the DAFNE-Report-BE                         *"
echo "  *                                                                               *"
echo "  *********************************************************************************"

export version=$1

if [ -z "$1" ]; then
    echo "[WARNING] No verions supplied: setting default value to SNAPSHOT"
    version="SNAPSHOT"
fi

echo "Shutting down DAFNE-Report-BE..."
docker-compose down || { echo "docker-compose command not found. Trying with docker compose instead.."; docker compose down; }

echo "DAFNE-Report-BE stopped"

echo "Remove symbolic link..."
echo "rm /data/dafne-report"
rm /data/dafne-report

echo "Create directory for release $version..."

echo "mkdir -p /data/dafne-report_${version} "
mkdir -p /data/dafne-report_${version}

echo "Create new symbolic link..."

echo "ln -s  /data/dafne-report_${version} /data/dafne-report"
ln -s  /data/dafne-report_${version} /data/dafne-report

echo "Copy the configuration files in the proper folder..."

echo "cp -R data/dafne-report/* /data/dafne-report_${version}/"
cp -R data/dafne-report/* /data/dafne-report_${version}/

echo "Pull images..."
docker-compose pull || { echo "docker-compose command not found. Trying with docker compose instead.."; docker compose pull; }

echo "DAFNE-Report-BE environment ready!"
