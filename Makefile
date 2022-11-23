build_lambda_deployment:
	echo "### build code ###"

	yarn tsc

	echo "### remove old zip ###"

	rm build/payload.zip

	echo "### create zip file ###"

	zip -j payload.zip src/handlers/shopify-update.js

	echo "### move to build directory ###"
	mv payload.zip build/payload.zip

init: 
	cd terraform && terraform init

plan: 
	cd terraform && terraform plan -out plan.tfplan

apply: 
	cd terraform && terraform apply plan.tfplan

deploy: plan apply
