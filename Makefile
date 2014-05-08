version := $(shell grep "^version" metadata.rb | sed -E 's/[a-z ]+"(.+)"/\1/g')

builddir = .build
staging = $(builddir)/exhibitor

$(staging):
	@mkdir -p $(staging)

metadata.json:
	 @knife cookbook metadata from file metadata.rb

$(staging)/metadata.json: metadata.json $(staging)
	@mv metadata.json $(staging)

chef-exhibitor-$(version).tar:
	@git archive --format tar -o chef-exhibitor-$(version).tar --prefix exhibitor/ HEAD

chef-exhibitor-$(version).tar.gz: $(staging)/metadata.json chef-exhibitor-$(version).tar
	@tar -uf chef-exhibitor-$(version).tar -C $(builddir) exhibitor/metadata.json
	@gzip chef-exhibitor-$(version).tar

.PHONY=build clean

tag:
	@git tag v$(version)
	@git push --tags

build: clean chef-exhibitor-$(version).tar.gz tag

clean:
	@rm -f chef-exhibitor-*.tar.gz
	@rm -rf $(builddir)
	@rm -f metadata.json
