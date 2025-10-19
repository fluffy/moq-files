
all: draft-jennings-moq-file.txt draft-jennings-moq-file.html

clean:
	- rm draft-jennings-moq-file.xml draft-jennings-moq-file.txt draft-jennings-moq-file.html

draft-jennings-moq-file.xml: draft-jennings-moq-file.md
	kramdown-rfc  --v3  draft-jennings-moq-file.md > draft-jennings-moq-file.xml

draft-jennings-moq-file.txt: draft-jennings-moq-file.xml
	xml2rfc --text  draft-jennings-moq-file.xml

draft-jennings-moq-file.html: draft-jennings-moq-file.xml
	xml2rfc --html  draft-jennings-moq-file.xml


