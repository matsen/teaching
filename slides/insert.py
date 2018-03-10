#!/usr/bin/env python

import functools
import envoy
import os
import os.path
import shlex
import sys
import re

from lxml.html import builder as E, tostring
from lxml import etree

BASE_URL = os.environ.get('TALKS_BASE_URL', "file:///" + os.path.abspath('.') + '/')


def text_to_path(img_name):
    # Ugly but prevents over-writing.
    nofonts_name = re.sub('.svg$', '', img_name)+'_nofonts.svg'
    if not os.path.exists(img_name):
        raise Exception(img_name+'does not exist!')
    if os.path.exists(nofonts_name) and \
        os.path.getmtime(img_name) < os.path.getmtime(nofonts_name):
        return nofonts_name
    # else...
    r = envoy.run(
        'inkscape --without-gui --export-text-to-path --export-plain-svg={} {}'.format(
            nofonts_name, img_name))
    if r.status_code != 0:
        raise Exception(r.std_err)
    return nofonts_name


def replace_fonts(func):
    """
    Runs replace_fonts_in_svg on the first argument, and links to the result.

    This is a decorator.
    """
    # Uncomment if you would like to turn off text-to-path.
    # return func

    @functools.wraps(func)
    def inner(img_name, *args, **kwargs):
        if img_name.endswith('.svg') and '_refontified' not in img_name:
            img_name = text_to_path(img_name)
        return func(img_name, *args, **kwargs)

    return inner

def div(class_name, text):
    return E.DIV(E.CLASS(class_name), text)

def spacetop(spacing):
    return E.DIV(style='margin-top: {0};'.format(spacing))

@replace_fonts
def imgh(img_name, height="620"):
    return E.IMG(src=img_name, height=height)

@replace_fonts
def imgw(img_name, width="970"):
    return E.IMG(src=img_name, width=width)

@replace_fonts
def img(img_name):
    return E.IMG(src=img_name, **{"class": "stretch"})

@replace_fonts
def imgfl(img_name, height=None):
    if height:
        return E.IMG(src=img_name, height=height, **{"style": "float:left"})
    return E.IMG(src=img_name, **{"style": "float:left"})

@replace_fonts
def imgfr(img_name, height=None):
    if height:
        return E.IMG(src=img_name, height=height, **{"style": "float:right"})
    return E.IMG(src=img_name, **{"style": "float:right"})

def img_link(fn):
    """
    Wraps <img>-generating function ``fn`` such that the tag returned by
    calling ``fn`` is wrapped in a link to the full image.
    """
    @functools.wraps(fn)
    @replace_fonts
    def wrap_in_link(img_name, *args, **kwargs):
        return E.A(fn(img_name, *args, **kwargs), href=img_name, target='_blank')
    return wrap_in_link

imgl = img_link(img)
imghl = img_link(imgh)
imgwl = img_link(imgw)


def tree(tree_name, width="970", height="620"):
    return E.APPLET(
        E.PARAM(name="config_file", value=BASE_URL + 'src/aptx_configuration_file'),
        E.PARAM(name="url_of_tree_to_load", value=BASE_URL + tree_name),
        archive="forester.jar", code="org.forester.archaeopteryx.ArchaeopteryxE.class",
        codebase=BASE_URL, width=width, height=height, alt="applet broken")

func_dict = {
    "div": div,
    "tree": tree,
    "imgh": imgh,
    "imgw": imgw,
    "img": img,
    "imgfl": imgfl,
    "imgfr": imgfr,
    "imghl": imghl,
    "imgwl": imgwl,
    "imgl": imgl,
    "spacetop": spacetop
}

def map_fun(argl):
    func_name = argl.pop(0)
    return func_dict[func_name](*argl)

def get_fun(line):
    if line.startswith("^"):
        return tostring(map_fun(shlex.split(line[1:]))) + '\n'
    if line.startswith("(*"):
        return ""
    return line

for line in sys.stdin:
    sys.stdout.write(get_fun(line))
