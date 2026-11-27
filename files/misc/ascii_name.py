#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Print the plain Latin ASCII version of a name.

Usage: ascii_name.py '<name as a JSON string>'

The name is passed as a JSON string (non-ASCII characters escaped), so that
it survives any locale setting on the target host.

Accents are removed, Cyrillic and Greek letters are transliterated with the
tables below and everything else (e.g. Chinese, Arabic, Hebrew, Hindi) is
handed to the Unidecode Python package, which must be installed.
"""

from __future__ import absolute_import, division, print_function

import json
import sys
import unicodedata

# Letters that do not decompose into a base letter plus an accent
_LATIN = {
    "\u00df": "ss",
    "\u00e6": "ae",
    "\u0153": "oe",
    "\u00f8": "o",
    "\u0111": "d",
    "\u0142": "l",
    "\u00f0": "d",
    "\u00fe": "th",
    "\u0131": "i",
}

# Cyrillic (Russian, Ukrainian, Belarusian, Bulgarian, Serbian, Macedonian)
_CYRILLIC = {
    "\u0430": "a",
    "\u0431": "b",
    "\u0432": "v",
    "\u0433": "g",
    "\u0434": "d",
    "\u0435": "e",
    "\u0451": "yo",
    "\u0436": "zh",
    "\u0437": "z",
    "\u0438": "i",
    "\u0439": "y",
    "\u043a": "k",
    "\u043b": "l",
    "\u043c": "m",
    "\u043d": "n",
    "\u043e": "o",
    "\u043f": "p",
    "\u0440": "r",
    "\u0441": "s",
    "\u0442": "t",
    "\u0443": "u",
    "\u0444": "f",
    "\u0445": "kh",
    "\u0446": "ts",
    "\u0447": "ch",
    "\u0448": "sh",
    "\u0449": "shch",
    "\u044a": "",
    "\u044b": "y",
    "\u044c": "",
    "\u044d": "e",
    "\u044e": "yu",
    "\u044f": "ya",
    "\u0454": "ye",
    "\u0456": "i",
    "\u0457": "yi",
    "\u0491": "g",
    "\u045e": "u",
    "\u0458": "j",
    "\u0459": "lj",
    "\u045a": "nj",
    "\u045b": "c",
    "\u0452": "dj",
    "\u045f": "dz",
    "\u0453": "gj",
    "\u045c": "kj",
    "\u0455": "dz",
}

# Greek (accented letters are handled after the accents are stripped)
_GREEK = {
    "\u03b1": "a",
    "\u03b2": "v",
    "\u03b3": "g",
    "\u03b4": "d",
    "\u03b5": "e",
    "\u03b6": "z",
    "\u03b7": "i",
    "\u03b8": "th",
    "\u03b9": "i",
    "\u03ba": "k",
    "\u03bb": "l",
    "\u03bc": "m",
    "\u03bd": "n",
    "\u03be": "x",
    "\u03bf": "o",
    "\u03c0": "p",
    "\u03c1": "r",
    "\u03c3": "s",
    "\u03c2": "s",
    "\u03c4": "t",
    "\u03c5": "y",
    "\u03c6": "f",
    "\u03c7": "ch",
    "\u03c8": "ps",
    "\u03c9": "o",
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
_OU = (("\u03bf\u03c5", "ou"), ("\u039f\u03c5", "Ou"), ("\u039f\u03a5", "OU"))


def _transliterate(text, table):
    return "".join(table.get(char, char) for char in text)


def ascii_name(value, unidecode):
    """Return value as plain ASCII, e.g. 'Kov\u00e1cs' -> 'Kovacs'."""
    text = _transliterate(value, _BEFORE_STRIP)
    decomposed = unicodedata.normalize("NFKD", text)
    stripped = "".join(char for char in decomposed if not unicodedata.combining(char))
    for greek, latin in _OU:
        stripped = stripped.replace(greek, latin)
    text = _transliterate(stripped, _AFTER_STRIP)
    result = []
    for char in text:
        if ord(char) < 128:
            result.append(char)
        else:
            result.append(unidecode(char))
    return "".join(result)


def main():
    """Read the JSON string argument and print its ASCII version."""
    try:
        # Optional dependency: a missing package gets a clear message below.
        # pylint: disable-next=import-outside-toplevel
        from unidecode import unidecode
    except ImportError:
        sys.stderr.write(
            "Unidecode is required (python3-unidecode or pip install Unidecode)\n"
        )
        return 2
    if len(sys.argv) != 2:
        sys.stderr.write("Usage: ascii_name.py JSON_STRING\n")
        return 1
    sys.stdout.write(ascii_name(json.loads(sys.argv[1]), unidecode))
    return 0


if __name__ == "__main__":
    sys.exit(main())
