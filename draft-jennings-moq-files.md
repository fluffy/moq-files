---
title: "Serialization of MoQ Objects to Files"
abbrev: "Moq Object Files"
docname: draft-jennings-moq-file-01
date: {DATE}
category: std

ipr: trust200902
area:  "Web and Internet Transport"
submissionType: IETF
workgroup: "moq"
keyword:
 - moq 

stand_alone: yes
smart_quotes: no
pi: [sortrefs, symrefs]

author:
  -
    ins: C. Jennings
    name: Cullen Jennings
    organization: Cisco
    email: fluffy@iii.ca
 
normative:
    MOQT: I-D.ietf-moq-transport

informative:


--- abstract

This specification provides a way to save the meta data about each MoQ
Object in one or more files as well as pointers to other files that
contain the contents of the object.  Separating of the meta data and
payload data allow the payload data to remain in files that are used for
other purposes such as serving HLS/DASH video.  This format makes it
easier to test and develop caching relays and create test data they can
serve to client.


--- middle

# Introduction

This specification defines a way of serializing the MoQ Objects defined
in {{MOQT}} into files. The payload data and the meta data are separated
into separate files to allow reuse of existing files with the payload
data. 


# JSON Meta Object

The .moq files consist of an array of one or more JSON objects. Each
JSON object contains information about the MOQT object as well as
pointers to the where the original data can be found.

The follow fields are defined for JSON object:

* namesSpace: Array of strings that have a Base64 encoded version of the
  data in each tuple of MOQT Track Namespace.

* trackName: string with Base64 encoded version of the MOQT TrackName.

* objectID: integer corresponding to the MOQT ObjectID

* groupID: integer corresponding to the MOQT GroupID

* subGroup: integer corresponding to the MOQT SubGroup

* publisherPriority: integer corresponding to the MOQT Object
  publisherPriority

* maxCacheDuration: integer corresponding to the MOQT maxCacheDuration

* publisherDeliveryTimeout: integer corresponding to the MOQT
publisherDeliveryTimeout

* receiveTime: time was created or time original was received
received by the relay. This is in milliseconds since the unix epoch.

* dataFile: string with relative path name to the file that stores the
MOQT Object, including header and its payload data.

* dataOffset: number of bytes into file where objects starts ( 0 is
first byte of file )

* dataLength: number of bytes of data in the object

Any extension attributes should also be saved using a field name formed
by the string "ext" then the base 10 integer representation of the
extension type ID.


# File Naming

It is RECOMMENDED to use a URL encoding version of the FullTrackName
with a suffix of ".moq" as the file name for the meta file. In this
context FullTrackName is concatenation of Track Namespace with the
TrackName, separated by "/". Optionally, the filename can be extended
with information about group as needed.

# MOQT Track DataFile

When saving a whole MOQT Track to a file, a common way to do this would
be to make one ".dat" file with all the object data and another ".moq"
file with all the array of JSON object for each MOQT Object. An
implementation can choose to have one file per MOQT group. In such a
case, it does so by creating one metadata (".moq") file and one
datafile (".dat") containing data for each object in the MOQT group.

# Playback

Some use cases will want to just load a file into the relay as quickly as
possible. Other may decide to remade the track name to a new track name
publish the objects at a rate based on differences of the receiveTime of
the JSON objects.

# Example

TODO More complete example

## Time Object Example

Data file named time1.dat contains:

~~~
{"time":17294570764566}
~~~

Metadata file contains:

~~~
[
	{
		"namesSpace": "bW9xOi8vbW9xLXRpbWUuYXJwYS90aW1lLXYxLw=",
		"trackName": "bWFjOjcyOjVjOmYwOjdjOmJmOmIw",
		"objectID": 0,
		"groupID": 123,
		"subGroup": 0,
		"publisherPriority": 0,
		"maxCacheDuration": 3600000,
		"publisherDeliveryTimeout": 60000,
		"receiveTime": 1729457464000,
		"dataFile": "time1.dat",
		"dataOffset": 0,
		"dataLength": 25
	}
]
~~~


# IANA

TODO file extension registrations.

# Security Considerations {#sec-security}

TODO

