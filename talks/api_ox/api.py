import logging

from redis import StrictRedis
import requests
from requests.exceptions import RequestException
import cachecontrol
from cachecontrol.caches import RedisCache

logger = logging.getLogger(__name__)


class ApiOxResource(object):

    def __init__(self, base_url, timeout=1):
        self.base_url = base_url
        self.timeout = timeout

    def _get_request(self, path, params=None):
        try:
            redis = StrictRedis(host='localhost', port=6379, db=0)
            session = cachecontrol.CacheControl(requests.Session(), RedisCache(redis))
            r = session.get('{base_url}{path}'.format(base_url=self.base_url, path=path),
                             timeout=self.timeout,
                             headers={'User-Agent': 'talks.ox'})
            if r.status_code == requests.codes.ok:
                return r.json()
            elif r.status_code == requests.codes.not_found:
                raise ApiNotFound()
            else:
                logger.error("Bad response code {code} from the API".format(code=r.status_code))
                raise ApiException()
        except RequestException as re:
            logger.error("Unable to reach the API", exc_info=True)
            raise ApiException()


class PlacesResource(ApiOxResource):

    PATH = '/places/'

    def get_by_id(self, ident):
        return self._get_request('{path}{ident}'.format(path=self.PATH, ident=ident))

    def get_organisation_descendants(self, ident):
        return self._get_request('{path}{ident}/organisation-descendants'.format(path=self.PATH, ident=ident))


class DatesResource(ApiOxResource):

    def get_oxford_date(self, py_date):
        return self._get_request('/dates/{year}-{month}-{day}'.format(year=py_date.year,
                                                                      month=py_date.month,
                                                                      day=py_date.day))


class ApiException(Exception):

    message = "API is not available"


class ApiNotFound(ApiException):

    message = "Resource not found"
