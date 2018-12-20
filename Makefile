check-variables:
ifndef PROJECT
  $(error PROJECT is undefined)
endif
ifndef IMAGE_NAME
  $(error IMAGE_NAME is undefined)
endif

build: check-variables
	packer build -var 'project_id=${PROJECT}' -var 'image_name=${IMAGE_NAME}' packer.json

force-build: check-variables
	packer build -force -var 'project_id=${PROJECT}' -var 'image_name=${IMAGE_NAME}' packer.json
