from django.shortcuts import get_object_or_404

from rest_framework import viewsets, status
from rest_framework.decorators import api_view
from rest_framework.renderers import JSONRenderer, JSONPRenderer, XMLRenderer
from rest_framework.response import Response

from talks.events.models import Event, Speaker
from talks.api.serializers import (EventSerializer, SpeakerSerializer,
                                   CollectionItemSerializer)
from talks.core.renderers import ICalRenderer


class EventViewSet(viewsets.ModelViewSet):
    """API endpoint for events
    """
    renderer_classes = (ICalRenderer, JSONRenderer, JSONPRenderer, XMLRenderer)
    queryset = Event.objects.all()
    serializer_class = EventSerializer


# These views are typically used by ajax

@api_view(["GET"])
def suggest_speaker(request):
    query = request.GET.get('q', '')
    speakers = Speaker.objects.suggestions(query)
    serializer = SpeakerSerializer(speakers, many=True)
    return Response(serializer.data)


# TODO: require auth
@api_view(["POST"])
def create_speaker(request):
    serializer = SpeakerSerializer(data=request.DATA)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# TODO: require auth
@api_view(["POST"])
def save_talk(request, collection_id=None):
    print request.DATA
    user_collection = request.tuser.default_collection
    event_id = request.DATA['event']
    event = get_object_or_404(Event, id=event_id)
    item = user_collection.collectionitem_set.create(item=event)
    serializer = CollectionItemSerializer(item)
    return Response(serializer.data, status=status.HTTP_201_CREATED)
