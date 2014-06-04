from django.db import models


class ApiPlaceModel(models.Model):
    identifier = models.CharField(db_index=True,
                                   unique=True,
                                   max_length=50)
    name = models.CharField(max_length=250)

    def __unicode__(self):
        return "{name} <{ident}>".format(name=self.name,
                                         ident=self.identifier)

    class Meta:
        abstract = True


class Location(ApiPlaceModel):
    # TODO what should be stored here? what IS a location?
    # (e.g. building vs actual room of the event)
    # (e.g. additional information, accessibility etc)
    pass


class Organisation(ApiPlaceModel):
    pass
