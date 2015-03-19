*************************
Retrieve Talks via Search
*************************

.. http:get:: /talks/search

    Search for Talks

    **Example request**:

    .. sourcecode:: http

		GET /api/talks/search?from=today&topic=X HTTP/1.1
		Host: talks.ox.ac.uk
		Accept: application/json

    **Example response**:

    .. sourcecode:: http

        HTTP/1.1 200 OK
        Content-Type: application/json

        {
            "_links": {
                "self": {
                    "href": "http://talks.ox.ac.uk/api/talks/search?from=01/01/01"
                },
                "next": null,
                "prev": null
            },
            "_embedded":
                {
                    "talks": [
                    {
                        "_links": {
                            "self": {
                                "href": "/api/talks/fa67d13a-f17d-471d-b8cc-33b3d7759956"
                            },
                            "talks_page": {
                                "href": "/talks/id/fa67d13a-f17d-471d-b8cc-33b3d7759956/"
                            }

                        },
                        "title": "What can babies with Down syndrome possibly tell us about Alzheimer's dementia in adults?",
                        "start": "2015-01-29T18:00:00Z",
                        "end": "2015-01-29T19:00:00Z",
                        "formatted_date": "29 January 2015, 18:00",
                        "formatted_time": "18:00",
                        "description": "It may seem paradoxical to focus on babies ...",
                        "_embedded":
                        {
                            "speakers": [ ],
                            "venue": {
                                "_links": {
                                    "self": {
                                        "href": "//api.m.ox.ac.uk/places/oxpoints:50009121"
                                    }
                                },
                                "name": "Mary Gray Allen Building",
                                "map_link": "//maps.ox.ac.uk/#/places/oxpoints:50009121"

                            },
                            "organising_department": null,
                            "topics": [
                                {
                                    "uri": "http://id.worldcat.org/fast/806532",
                                    "label": "Alzheimer's disease"
                                }, {
                                    "uri": "http://id.worldcat.org/fast/890050",
                                    "label": "Dementia"
                                }
                            ]
                        }
                    }
                    ]
                }
            }

    :query from: Date to start filtering on (mandatory). Format should be dd/mm/yy OR 'today' or 'tomorrow'
    :type from: string
    :query to: Optional date to end filtering. Format should be dd/mm/yy OR 'today' or 'tomorrow'
    :type to: string
    :query subdepartments: Optional. Defaults to true. If true, include all sub-organisations of the specified department within the search
    :type subdepartments: boolean

    The below parameters can each be repeated multiple times

    :query topic: Topic URI
    :type topic: string
    :query venue: Search for talks taking place at the location specified by the oxpoints ID
    :type venue: string
    :query organising_department: Search for talks whose organising department is the organisation specified by this oxpoints ID
    :type organising_department: string
    :query speaker: Search for talks at which the specified person is a speaker. Supply the unique slug for the person e.g. 'd47e2458-af73-4bc1-bf04-3c275e1c1254'
    :type speaker: string

    The response can be either in XML or JSON dependent on the 'accept' header in the request.

    :statuscode 200: query found
    :statuscode 400: Bad request (could happen if some parameters are missing or incorrectly formed such as `from`)
    :statuscode 503: Service not available
