check-variables:
ifndef PROJECT
  $(error PROJECT is undefined)
endif
ifndef IMAGE_NAME
  $(error IMAGE_NAME is undefined)
endif

build: check-variables
	if [[ $$DOCKER_COMPOSE_PATH ]]; then mkdir -p files/compose/$$IMAGE_NAME; cp $$DOCKER_COMPOSE_PATH files/compose/$$IMAGE_NAME/; fi; \
	packer build -var 'project_id=${PROJECT}' -var 'image_name=${IMAGE_NAME}' packer.json; \
	if [[ $$DOCKER_COMPOSE_PATH ]]; then rm -rf files/compose/$$IMAGE_NAME; fi;


force-build: check-variables
	if [[ $$DOCKER_COMPOSE_PATH ]]; then mkdir -p files/compose/$$IMAGE_NAME; cp $$DOCKER_COMPOSE_PATH files/compose/$$IMAGE_NAME/; fi; \
	packer build -force -var 'project_id=${PROJECT}' -var 'image_name=${IMAGE_NAME}' packer.json; \
	if [[ $$DOCKER_COMPOSE_PATH ]]; then rm -rf files/compose/$$IMAGE_NAME; fi;
