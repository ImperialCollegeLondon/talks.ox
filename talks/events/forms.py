from django import forms
from django.forms.widgets import TextInput, Select
from django.utils.safestring import mark_safe
from django.conf import settings

from talks.api_ox.models import Location, Organisation
from .models import Event, EventGroup, Speaker
from talks.events.models import Topic


class BootstrappedDateTimeWidget(forms.DateTimeInput):
    def render(self, name, value, attrs=None):
        html = super(BootstrappedDateTimeWidget, self).render(name, value, attrs)
        html = """<div class="input-group">
                <span class="input-group-btn">
                    <button class="btn btn-default js-open-calendar" type="button"><span class="glyphicon glyphicon-calendar"></span></button>
                </span>
        """ + html + "</div>"
        return mark_safe(html)


class ModelCommaSeparatedChoiceField(forms.ModelMultipleChoiceField):
    widget = forms.HiddenInput

    def clean(self, value):
        if value:
            value = [item.strip() for item in value.split(",")]
        return super(ModelCommaSeparatedChoiceField, self).clean(value)


class APIOxField(forms.ModelChoiceField):
    def __init__(self, *args, **kwargs):
        self.Model = kwargs.pop('Model', [])
        self.types = kwargs.pop('types', [])
        self.endpoint = kwargs.pop(
            'endpoint', '//api.m.ox.ac.uk/places/suggest')
        return super(APIOxField, self).__init__(*args, **kwargs)

    def clean(self, value):
        if not value:
            return None  # FIXME
        instance, _created = self.Model.objects.get_or_create(identifier=value)
        return super(APIOxField, self).clean(instance.pk)


class TopicsField(forms.ModelMultipleChoiceField):

    widget = forms.HiddenInput

    def __init__(self, *args, **kwargs):
        self.endpoint = kwargs.pop('endpoint', settings.TOPICS_URL)
        return super(TopicsField, self).__init__(*args, **kwargs)

    def clean(self, value):
        ids = []
        if value:
            value = [item.strip() for item in value.split(",")]
            ids = [Topic.objects.get_or_create(uri=v)[0].pk for v in value]
        return super(TopicsField, self).clean(ids)


class SpeakerTypeaheadInput(forms.TextInput):
    class Media:
        js = ('js/element-typeahead.js',)


class TopicTypeaheadInput(forms.TextInput):
    class Media:
        js = ('js/element-typeahead.js',)


class EventForm(forms.ModelForm):
    speaker_suggest = forms.CharField(
        label="Speaker",
        help_text="Type speakers name and select from the list.",
        required=False,
        widget=SpeakerTypeaheadInput(attrs={'class': 'js-speakers-typeahead'}),
    )
    speakers = ModelCommaSeparatedChoiceField(
        queryset=Speaker.objects.all(),
        required=False)

    topic_suggest = forms.CharField(
        label="Topic",
        help_text="Type topic name and select from the list",
        required=False,
        widget=TopicTypeaheadInput(attrs={'class': 'js-topics-typeahead'}),
    )
    topics = TopicsField(
        queryset=Topic.objects.all(),
        required=False,
    )

    location_suggest = forms.CharField(
        label="Venue",
        required=False,
        widget=forms.TextInput(attrs={'class': 'js-location-typeahead'}),
    )
    location = APIOxField(
        Model=Location,
        queryset=Location.objects.all(),
        required=False,
        types=['/university/building', '/university/site', '/leisure/museum', '/university/college', '/university/library'],
        widget=forms.HiddenInput(attrs={'class': 'js-location'}),
    )

    department_suggest = forms.CharField(
        label="Department",
        required=False,
        widget=forms.TextInput(attrs={'class': 'js-organisation-typeahead'}),
    )
    department_organiser = APIOxField(
        Model=Organisation,
        queryset=Organisation.objects.all(),
        required=False,
        types=['/university/department', '/university/museum', '/university/college'],
        widget=forms.HiddenInput(attrs={'class': 'js-organisation'}),
    )
    group = forms.ModelChoiceField(
        EventGroup.objects.all(),
        empty_label="-- select a group --",
        widget=Select(attrs={'class': 'form-control'}),
        required=False,
    )

    class Media:
        js = ('js/location-typeahead.js',)

    class Meta:
        exclude = ('slug', 'topics')
        model = Event
        labels = {
            'description': 'Abstract',
        }
        widgets = {
            'start': BootstrappedDateTimeWidget(attrs={'readonly': True, 'class': 'js-datetimepicker event-start'}),
            'end': BootstrappedDateTimeWidget(attrs={'readonly': True, 'class': 'js-datetimepicker event-end'}),
        }


class EventGroupForm(forms.ModelForm):

    class Meta:
        fields = ('title', 'group_type', 'description')
        model = EventGroup
        widgets = {
            'title': forms.TextInput(),
            'description': forms.Textarea(),
        }


class SpeakerQuickAdd(forms.ModelForm):
    class Meta:
        fields = ('name', 'email_address')
        model = Speaker

    class Media:
        js = ('js/event-element-quick-add.js',)
