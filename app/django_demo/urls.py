# coding: utf-8
import sys
sys.path.append('../')
from api.urls import router as api_router

from django.conf.urls import url, include
from django.contrib import admin


urlpatterns = [
    url(r'^admin/', admin.site.urls),
    # blog.urlsをincludeする
    url(r'^api/', include(api_router.urls)),
]