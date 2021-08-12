#!/bin/sh
RUN_DIR=`pwd`
cd ..
BASE_DIR=`pwd`

cd $BASE_DIR/appserver/epayment && docker-compose up -d

cd $BASE_DIR/appserver/etracs && docker-compose -f docker-compose.yml -f docker-compose-ext.yml up -d

cd $BASE_DIR/appserver/market && docker-compose up -d

cd $RUN_DIR
