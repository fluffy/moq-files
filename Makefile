
all: draft-jennings-moq-files.txt


draft-jennings-moq-files.xml: draft-jennings-moq-files.md
	kramdown-rfc  --v3  draft-jennings-moq-files.md > draft-jennings-moq-files.xml

draft-jennings-moq-files.txt: draft-jennings-moq-files.xml
	xml2rfc --text  draft-jennings-moq-files.xml


