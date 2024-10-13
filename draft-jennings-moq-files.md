---
title: "Serialization of MoQ Objects to Files"
abbrev: moq-transport
docname: draft-jennings-moq-file-00
date: {DATE}
category: std

ipr: trust200902
area:  "Web and Internet Transport"
submissionType: IETF
workgroup: "moq"
keyword:
 - media over quic

stand_alone: yes
smart_quotes: no
pi: [toc, sortrefs, symrefs, docmapping]

author:
  -
    ins: C. Jennings
    name: Cullen Jennings
    organization: Cisco
    email: fluffy@iii.ca

 
normative:

informative:

--- abstract


A common way to serial the MoQ caches to files makes it easier to test
and develop caching relays and great test data they can server to
client.  The specification provides a way to save the meta data about
each MoQ Object in one file as well as pointers to other files that
contain the contents of the object. This allow the data to remain in
files that are used for other purposes such as serving HLS/DASH video.

--- middle


# Introduction



# Meta Object

The .moq files consist of an array of one more more JSON objects. Each
JSON object contains information about the MoQ object as well as
pointers to the where the original data can be found. The follow fields
are defined for JSON object.

namesSpace: Array of stings that have Base64 encoded of data in each
segment of namesSpace

trackName: string with Base64 encoded version of track name

objectID: integer

groupID: integer

subGroup: integer

publisherPriority: integer

maxCacheDuration: integer

publisherDeliveryTimeout: integer


receiveTime: time data was created or original received by relay in
milliseconds since unix epoch

dataFile: string with relative path name to file that stores the object
data

dataOffset: number of bytes into file where objects starts ( 0 is first
byte of file )

dataLength: number of bytes of data in the object

