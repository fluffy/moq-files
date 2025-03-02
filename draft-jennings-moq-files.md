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
    MoQT: I-D.ietf-moq-transport

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
in {{MoQT}} into files. The payload data and the meta data are separated
into separate files to allow reuse of existing files with the payload
data. 


# JSON Meta Object

The .moq files consist of an array of one or more JSON objects. Each
JSON object contains information about the MoQT object as well as
pointers to the where the original data can be found.

The follow fields are defined for JSON object:

* namesSpace: Array of strings that have a Base64 encoded version of the
  data in each tuple of MoQT Track Namespace as defined in {{MoQT}}.

* trackName: string with Base64 encoded version of the MoQT Trackname as
  defined in {{MoQT}}.

* objectID: integer corresponding to the MoQT Object ID as defined in
  {{MoQT}}.

* groupID: integer corresponding to the MoQT Group ID as defined in
  {{MoQT}}.

* subGroup: integer corresponding to the MoQT Subgroup as defined in
  {{MoQT}}.

* forwardingPref: String with value of "Subgroup" or "Datagram" to
  represent the Object Forwarding Preference as defined in
  {{MoQT}}. Open Issue: string or use the binary values used in spec?

* objectStatus: Numeric value representing Object Status as defined in
  {{MoQT}}.

* publisherPriority: integer corresponding to the MoQT Publisher
  Priority as defined in {{MoQT}}.

* maxCacheDuration: integer corresponding to the MoQT publisher MAX
  CACHE DURATION Parameter as defined in {{MoQT}}.

* publisherDeliveryTimeout: integer corresponding to the MoQT DELIVERY
  TIMEOUT Parameter sent by the publisher as defined in {{MoQT}}.

* receiveTime: time original object was created (if known) or time
  object was received by the relay.  This is in milliseconds since the
  unix epoch.

* dataFile: string with relative path name to the file that stores the
  MoQT Object, including header and its payload data.

* dataOffset: number of bytes into file where objects starts ( 0 is
  first byte of file )

* dataLength: number of bytes of data in the object

Any Object Extension Headers, as defined in {{MoQT}}, should also be
saved using a field name formed by the string "ext" then the base 10
integer representation of the extension type with a value that is the
Base64 encoded version of the extension header data.  Open Issue: this
will not preserve the oder of the extension headers. Is that a problem?


# File Naming

It is RECOMMENDED to use a URL encoding version of the FullTrackName
with a suffix of ".moq" as the file name for the meta file. In this
context FullTrackName is concatenation of Track Namespace with the
TrackName, separated by "_". Optionally, the filename can be extended
with information about group as needed.

# MoQT Track DataFile

When saving a whole MoQT Track to a file, a common way to do this would
be to make one ".dat" file with all the object data and another ".moq"
file with all the array of JSON object for each MoQT Object. An
implementation can choose to have one file per MoQT group. In such a
case, it does so by creating one metadata (".moq") file and one
datafile (".dat") containing data for each object in the MoQT group.

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

