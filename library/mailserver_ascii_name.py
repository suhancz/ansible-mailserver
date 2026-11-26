#!/usr/bin/python
# -*- coding: utf-8 -*-
"""Ansible module that turns a name in any script into plain Latin ASCII."""
from __future__ import absolute_import, division, print_function

__metaclass__ = type

DOCUMENTATION = r"""
---
module: mailserver_ascii_name
short_description: Transliterate a name to plain Latin ASCII
description:
  - Removes accents, transliterates Cyrillic and Greek with built-in tables
    and transliterates every other script with the Unidecode Python package.
  - Runs on the managed node, which therefore needs the Unidecode package
    (the role installs it).
options:
  text:
    description: The text to convert.
    type: str
    required: true
author:
  - Akos Balla
"""

EXAMPLES = r"""
- name: Convert a name
  mailserver_ascii_name:
    text: "Kov\u00e1cs"
  register: converted
# converted.ascii == "Kovacs"
"""

RETURN = r"""
ascii:
  description: The text converted to ASCII.
  returned: success
  type: str
"""

import unicodedata

from ansible.module_utils.basic import AnsibleModule, missing_required_lib

try:
    from unidecode import unidecode
    UNIDECODE_IMPORT_ERROR = None
except ImportError as import_error:
    unidecode = None
    UNIDECODE_IMPORT_ERROR = str(import_error)

# Letters that do not decompose into a base letter plus an accent
_LATIN = {
    u'\u00df': u'ss', u'\u00e6': u'ae', u'\u0153': u'oe', u'\u00f8': u'o',
    u'\u0111': u'd', u'\u0142': u'l', u'\u00f0': u'd', u'\u00fe': u'th',
    u'\u0131': u'i',
}

# Cyrillic (Russian, Ukrainian, Belarusian, Bulgarian, Serbian, Macedonian)
_CYRILLIC = {
    u'\u0430': u'a', u'\u0431': u'b', u'\u0432': u'v', u'\u0433': u'g',
    u'\u0434': u'd', u'\u0435': u'e', u'\u0451': u'yo', u'\u0436': u'zh',
    u'\u0437': u'z', u'\u0438': u'i', u'\u0439': u'y', u'\u043a': u'k',
    u'\u043b': u'l', u'\u043c': u'm', u'\u043d': u'n', u'\u043e': u'o',
    u'\u043f': u'p', u'\u0440': u'r', u'\u0441': u's', u'\u0442': u't',
    u'\u0443': u'u', u'\u0444': u'f', u'\u0445': u'kh', u'\u0446': u'ts',
    u'\u0447': u'ch', u'\u0448': u'sh', u'\u0449': u'shch', u'\u044a': u'',
    u'\u044b': u'y', u'\u044c': u'', u'\u044d': u'e', u'\u044e': u'yu',
    u'\u044f': u'ya', u'\u0454': u'ye', u'\u0456': u'i', u'\u0457': u'yi',
    u'\u0491': u'g', u'\u045e': u'u', u'\u0458': u'j', u'\u0459': u'lj',
    u'\u045a': u'nj', u'\u045b': u'c', u'\u0452': u'dj', u'\u045f': u'dz',
    u'\u0453': u'gj', u'\u045c': u'kj', u'\u0455': u'dz',
}

# Greek (accented letters are handled after the accents are stripped)
_GREEK = {
    u'\u03b1': u'a', u'\u03b2': u'v', u'\u03b3': u'g', u'\u03b4': u'd',
    u'\u03b5': u'e', u'\u03b6': u'z', u'\u03b7': u'i', u'\u03b8': u'th',
    u'\u03b9': u'i', u'\u03ba': u'k', u'\u03bb': u'l', u'\u03bc': u'm',
    u'\u03bd': u'n', u'\u03be': u'x', u'\u03bf': u'o', u'\u03c0': u'p',
    u'\u03c1': u'r', u'\u03c3': u's', u'\u03c2': u's', u'\u03c4': u't',
    u'\u03c5': u'y', u'\u03c6': u'f', u'\u03c7': u'ch', u'\u03c8': u'ps',
    u'\u03c9': u'o',
}


def _build_table(*sources):
    table = {}
    for source in sources:
        for char, latin in source.items():
            table[char] = latin
            table[char.upper()] = latin.capitalize()
    return table


# Greek is applied only after the accents are stripped, so that e.g. the
# combination of omicron and upsilon can be handled as one sound
_BEFORE_STRIP = _build_table(_LATIN, _CYRILLIC)
_AFTER_STRIP = _build_table(_LATIN, _CYRILLIC, _GREEK)
_OU = ((u'\u03bf\u03c5', u'ou'), (u'\u039f\u03c5', u'Ou'), (u'\u039f\u03a5', u'OU'))


def _transliterate(text, table):
    return u''.join(table.get(char, char) for char in text)


def ascii_name(value):
    """Return value as plain ASCII, e.g. 'Kov\u00e1cs' -> 'Kovacs'.

    Accents are removed, Cyrillic and Greek letters are transliterated with
    the tables above and everything else (e.g. Chinese, Arabic, Hebrew,
    Hindi) is handed to Unidecode.
    """
    text = _transliterate(u'%s' % value, _BEFORE_STRIP)
    decomposed = unicodedata.normalize('NFKD', text)
    stripped = u''.join(char for char in decomposed if not unicodedata.combining(char))
    for greek, latin in _OU:
        stripped = stripped.replace(greek, latin)
    text = _transliterate(stripped, _AFTER_STRIP)
    result = []
    for char in text:
        if ord(char) < 128:
            result.append(char)
        else:
            result.append(unidecode(char))
    return u''.join(result)


def main():
    """Run the module."""
    module = AnsibleModule(
        argument_spec=dict(text=dict(type='str', required=True)),
        supports_check_mode=True,
    )
    if unidecode is None:
        module.fail_json(
            msg=missing_required_lib('Unidecode'),
            exception=UNIDECODE_IMPORT_ERROR,
        )
    module.exit_json(changed=False, ascii=ascii_name(module.params['text']))


if __name__ == '__main__':
    main()
