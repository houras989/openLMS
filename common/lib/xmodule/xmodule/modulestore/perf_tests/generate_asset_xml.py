#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Generates fake XML for asset metadata.
"""


import random
from lxml import etree
from datetime import datetime, timedelta
from xmodule.assetstore import AssetMetadata
from opaque_keys.edx.keys import CourseKey

try:
    import click
except ImportError:
    click = None

# Name of the asset metadata XML schema definition file.
ASSET_XSD_FILE = 'assets.xsd'

# Characters used in name generation below.
NAME_CHARS = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-'
NAME_CHARS_W_UNICODE = NAME_CHARS + 'àĚŘǅΦШΩΣӔ'


def coin_flip():
    """
    50/50 chance
    """
    return random.choice((True, False))


def asset_type():
    """
    Pick an asset type at random.
    """
    asset_type_choices = (
        (95, "asset"),
        (100, "video")
    )
    d100 = random.randint(0, 100)
    for choice in asset_type_choices:
        if d100 <= choice[0]:
            return choice[1]
    return asset_type_choices[-1][1]


def filename():
    """
    Fake a filename.
    """
    fname = ''
    for __ in range(random.randint(10, 30)):
        fname += random.choice(NAME_CHARS_W_UNICODE)
    fname += random.choice(('.jpg', '.pdf', '.png', '.txt'))
    return fname


def pathname():
    """
    Fake a pathname.
    """
    pname = ''
    for __ in range(random.randint(2, 3)):
        for __ in range(random.randint(5, 10)):
            pname += random.choice(NAME_CHARS)
        pname += '/'
    return pname


def locked():
    """
    Locked or unlocked.
    """
    return coin_flip()


def fields():
    """
    Generate some fake extra fields.
    """
    f = {}
    if coin_flip():
        if coin_flip():
            f['copyrighted'] = coin_flip()
        if coin_flip():
            f['size'] = random.randint(100, 10000000)
        if coin_flip():
            f['color'] = random.choice(('blue', 'pink', 'fuchsia', 'rose', 'mauve', 'black'))
    return f


def user_id():
    """
    Fake user id.
    """
    return random.randint(1, 100000000)


def versions():
    """
    Fake versions.
    """
    curr_ver = random.randint(1, 500)
    prev_ver = curr_ver - 1

    def ver_str(ver):
        """
        Version string.
        """
        return 'v{}.0'.format(ver)
    return (ver_str(curr_ver), ver_str(prev_ver))


def date_and_time():
    """
    Fake date/time.
    """
    start_date = datetime.now()
    time_back = timedelta(seconds=random.randint(0, 473040000))  # 15 year interval
    return start_date - time_back


def contenttype():
    """
    Random MIME type.
    """
    return random.choice((
        'image/jpeg',
        'text/html',
        'audio/aiff',
        'video/avi',
        'text/plain',
        'application/msword',
        'application/x-gzip',
        'application/javascript',
    ))


def generate_random_asset_md():
    """
    Generates a single AssetMetadata object with semi-random data.
    """
    course_key = CourseKey.from_string('org/course/run')
    asset_key = course_key.make_asset_key(asset_type(), filename())
    (curr_version, prev_version) = versions()
    return AssetMetadata(
        asset_key,
        pathname=pathname(),
        internal_name=str([filename() for __ in range(10)]),
        locked=locked(),
        contenttype=contenttype(),
        thumbnail=filename(),
        fields=fields(),
        curr_version=curr_version,
        prev_version=prev_version,
        edited_by=user_id(),
        edited_by_email='staff@edx.org',
        edited_on=date_and_time(),
        created_by=user_id(),
        created_by_email='staff@edx.org',
        created_on=date_and_time(),
    )


def make_asset_md(amount):
    """
    Make a number of fake AssetMetadata objects.
    """
    all_asset_md = []
    for __ in range(amount):
        all_asset_md.append(generate_random_asset_md())
    return all_asset_md


def make_asset_xml(amount, xml_filename):
    """
    Make an XML file filled with fake AssetMetadata.
    """
    all_md = make_asset_md(amount)
    xml_root = etree.Element("assets")
    for mdata in all_md:
        asset_element = etree.SubElement(xml_root, "asset")
        mdata.to_xml(asset_element)
    with open(xml_filename, "w") as xml_file:
        etree.ElementTree(xml_root).write(xml_file)


def validate_xml(xsd_filename, xml_filename):
    """
    Validate a generated XML file against the XSD.
    """
    with open(xsd_filename, 'r') as f:
        schema_root = etree.XML(f.read())

    schema = etree.XMLSchema(schema_root)
    xmlparser = etree.XMLParser(schema=schema)

    with open(xml_filename, 'r') as f:
        etree.fromstring(f.read(), xmlparser)

if click is not None:
    # pylint: disable=bad-continuation
    @click.command()
    @click.option('--num_assets',
                  type=click.INT,
                  default=10,
                  help="Number of assets to be generated by the script.",
                  required=False
                  )
    @click.option('--output_xml',
                  type=click.File('w'),
                  default=AssetMetadata.EXPORTED_ASSET_FILENAME,
                  help="Filename for the output XML file.",
                  required=False
                  )
    @click.option('--input_xsd',
                  type=click.File('r'),
                  default=ASSET_XSD_FILE,
                  help="Filename for the XSD (schema) file to read in.",
                  required=False
                  )
    def cli(num_assets, output_xml, input_xsd):
        """
        Generates a number of fake asset metadata items as XML - and validates the XML against the schema.
        """
        make_asset_xml(num_assets, output_xml)
        # Now - validate the XML against the XSD.
        validate_xml(input_xsd, output_xml)

if __name__ == '__main__':
    if click is not None:
        cli()  # pylint: disable=no-value-for-parameter
    else:
        print("Aborted! Module 'click' is not installed.")
