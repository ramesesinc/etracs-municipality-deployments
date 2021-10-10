#!/bin/sh
RUN_DIR=`pwd`
cd ..
BASE_DIR=`pwd`

cd $BASE_DIR/appserver/vehicle && docker-compose down

cd $BASE_DIR/appserver/vehicle && docker-compose up -d

cd $BASE_DIR/appserver/vehicle && docker-compose logs -f

cd $RUN_DIR
