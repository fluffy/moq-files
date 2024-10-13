---
title: "Serialization of MoQ Objects to Files"
abbrev: "Moq Object Files"
docname: draft-jennings-moq-file-00
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
JSON object contains information about the MoQ object as well as
pointers to the where the original data can be found.

The follow fields are defined for JSON object:

* namesSpace: Array of strings that have a Base64 encoded version of the data in each
segment of MoQT namesSpace

* trackName: string with Base64 encoded version of the MoQT trackName

* objectID: integer corresponding to the MoQT objectID

* groupID: integer corresponding to the MoQT groupID

* subGroup: integer corresponding to the MoQT subGroup

* publisherPriority: integer corresponding to the MoQT publisherPriority

* maxCacheDuration: integer corresponding to the MoQT maxCacheDuration

* publisherDeliveryTimeout: integer corresponding to the MoQT
publisherDeliveryTimeout

* receiveTime: time data was created or time original was received
received by the relay. This is in milliseconds since unix epoch.

* dataFile: string with relative path name to the file that stores the
MoQT Object Payload data

* dataOffset: number of bytes into file where objects starts ( 0 is
first byte of file )

* dataLength: number of bytes of data in the object

Any extension attributes should also be saved using a field name formed
by the string "ext" then the base 10 integer representation of the
extension type ID.


# Example

TODO example of time file 

# File Naming

It is RECOMMENDED to use a URL encoding version of the FullTrackName
with a suffix of ".moqm" as the file name for the meta file.


# Dumping

When saving a whole track to a files, a common way to do this would be
to make one ".data" file with all the object payloads and another
".moqm" file with all the array of JSON object for each MoQ Object.


# Playback

Some use case will want to just load a file into the relay as quickly as
possible. Other will wish to remade the track name to a new track name
publish the objects at a rate based on differences of the receiveTime of
the JSON objects.

# IANA

TODO file extension registrations.


