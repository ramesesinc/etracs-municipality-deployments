#!/bin/sh
RUN_DIR=`pwd`
cd ..
BASE_DIR=`pwd`

cd $BASE_DIR/appserver/market && docker-compose down

cd $BASE_DIR/appserver/market && docker-compose up -d

cd $BASE_DIR/appserver/market && docker-compose logs -f

cd $RUN_DIR
