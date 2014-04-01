include config.mk

.PHONY: all package check clean

all: $(PAGES) $(FEEDS) $(EXTRA)

package: all
	tar -cvzf $(NAME).tar.gz $(PAGES) $(EXTRA) $(FEEDS)

install: package
	mkdir -p $(PREFIX)
	tar -xzf $(NAME).tar.gz -C $(PREFIX)

check: $(PAGES)
	@check.sh

clean:
	rm -f $(PAGES) $(FEEDS) $(NAME).tar.gz

.SUFFIXES: .txt .html .xml

HEADER = head.html
FOOTER = foot.html

$(FEEDS): index.txt
	feeds.sh $< > $@

.txt.html: $(HEADER) $(FOOTER)
	@echo "MARKDOWN `basename $@`"
	@cat $(HEADER) > $@
	@markdown $< >> $@
	@cat $(FOOTER) >> $@
