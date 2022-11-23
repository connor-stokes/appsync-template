#!/bin/bash

echo "### build code ###"

yarn tsc

echo "### remove old zip ###"

rm build/payload.zip

echo "### create zip file ###"

zip -j payload.zip src/handlers/shopify-update.js

echo "### move to build directory ###"
mv payload.zip build/payload.zip