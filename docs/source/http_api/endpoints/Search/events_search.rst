*************
Search Events
*************

Endpoint to search and retrieve information about events.

All the responses conform to the `HAL specification <http://stateless.co/hal_specification.html>`_.

.. http:get:: /events/search

    Search for events

    **Example request**:

    .. sourcecode:: http

		GET /api/events/search?from=today&topic=X HTTP/1.1
		Host: talks.ox.ac.uk
		Accept: application/json

    **Example response**:

    .. sourcecode:: http

        HTTP/1.1 200 OK
        Content-Type: application/json

        {
          "_embedded": {
            "pois": [
              {
                "_links": {
                  "child": [
                    {
                      "href": "/places/atco:340000004H5",
                      "title": "Stop H5 St Aldates",
                      "type": [
                        "/transport/bus-stop"
                      ],
                      "type_name": [
                        "Bus stop"
                      ]
                    },
                  ],
                  "parent": {
                    "href": "/places/stoparea:340G00004000",
                    "title": "Oxford City Centre",
                    "type": [
                      "/transport/stop-area"
                    ],
                    "type_name": [
                      "Bus stop area"
                    ]
                  },
                  "self": {
                    "href": "/places/stoparea:340G00003140"
                  }
                },
                "distance": 0,
                "id": "stoparea:340G00003140",
                "identifiers": [
                  "stoparea:340G00003140"
                ],
                "lat": "51.7508834555",
                "lon": "-1.2571120376",
                "name": "St Aldates",
                "name_sort": "St Aldates",
                "type": [
                  "/transport/stop-area"
                ],
                "type_name": [
                  "Bus stop area"
                ]
              },
              {
                "_links": {
                  "curie": {
                    "href": "http://moxie.readthedocs.org/en/latest/http_api/rti.html#{type}",
                    "name": "rti",
                    "templated": true
                  },
                  "parent": {
                    "href": "/places/stoparea:340G00003140",
                    "title": "St Aldates",
                    "type": [
                      "/transport/stop-area"
                    ],
                    "type_name": [
                      "Bus stop area"
                    ]
                  },
                  "rti:bus": {
                    "href": "/places/atco:340000004H5/rti/bus",
                    "title": "Live bus departure times"
                  },
                  "self": {
                    "href": "/places/atco:340000004H5"
                  }
                },
                "distance": 0,
                "id": "atco:340000004H5",
                "identifiers": [
                  "atco:340000004H5",
                  "naptan:69326543"
                ],
                "lat": "51.7502787977",
                "lon": "-1.2567597994",
                "name": "Stop H5 St Aldates",
                "name_sort": "Stop H5 St Aldates",
                "type": [
                  "/transport/bus-stop"
                ],
                "type_name": [
                  "Bus stop"
                ]
              },
            ]
          },
          "_links": {
            "curies": [
              {
                "href": "http://moxie.readthedocs.org/en/latest/http_api/relations/{rel}.html",
                "name": "hl",
                "templated": true
              },
              {
                "href": "http://moxie.readthedocs.org/en/latest/http_api/relations/facet.html",
                "name": "facet"
              }
            ],
            "hl:first": {
              "href": "/places/search?q=aldates&facet=type&type=%2Ftransport&count=35"
            },
            "hl:last": {
              "href": "/places/search?q=aldates&facet=type&type=%2Ftransport&count=35"
            },
            "hl:types": [
              {
                "count": 10,
                "href": "/places/search?q=aldates&facet=type&type=%2Ftransport%2Fbus-stop",
                "name": "/transport/bus-stop",
                "title": [
                  "Bus stop"
                ],
                "value": "/transport/bus-stop"
              },
              {
                "count": 1,
                "href": "/places/search?q=aldates&facet=type&type=%2Ftransport%2Fstop-area",
                "name": "/transport/stop-area",
                "title": [
                  "Bus stop area"
                ],
                "value": "/transport/stop-area"
              }
            ],
            "self": {
              "href": "/places/search?q=aldates&facet=type&type=%2Ftransport&count=35&start=0"
            }
          },
          "query": "aldates",
          "size": 11
        }

    :query from: Date to start filtering on (mandatory). Format should be dd/mm/yy OR 'today' or 'tomorrow'
    :type from: string
    :query to: Optional date to end filtering. Format should be dd/mm/yy OR 'today' or 'tomorrow'
    :type to: string
    :query subvenues: If true, include all sub-locations of the specified venue within the search
    :type subvenues: boolean
    :query subdepartments: If true, include all sub-organisations of the specified department within the search
    :type subdepartments: boolean

    The below parameters can each be repeated multiple times

    :query topic: Topic URI
    :type topic: string
    :query venue: Search for talks taking place at the location specified by the oxpoints ID
    :type venue: string
    :query organising_department: Search for talks whose organising department is the organisation specified by this oxpoints ID
    :type organising_department: string
    :query speaker: Search for talks at which the specified person is a speaker. Supply the unique slug for the person e.g. 'james-bond'
    :type speaker: string

    The response can be either in XML or JSON dependent on the 'accept' header in the request.

    :statuscode 200: query found
    :statuscode 400: Bad request (could happen if some parameters are missing or incorrectly formed such as `from`)
    :statuscode 503: Service not available
