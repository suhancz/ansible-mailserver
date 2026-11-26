"""Unit tests of files/misc/ascii_name.py (run in the CI container)."""

import contextlib
import importlib.util
import io
import json
import pathlib
import sys
import unittest
from unittest import mock

SCRIPT = (
    pathlib.Path(__file__).resolve().parents[1] / "files" / "misc" / "ascii_name.py"
)


def load_script():
    """Load the script as a module without running it."""
    spec = importlib.util.spec_from_file_location("ascii_name", SCRIPT)
    assert spec is not None and spec.loader is not None
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def fake_unidecode(char):
    """Stand in for Unidecode and make the characters it receives visible."""
    return "[" + char + "]"


class AsciiNameTest(unittest.TestCase):
    """Tests of the conversion tables and of the command line."""

    def setUp(self):
        """Load the script before every test."""
        self.module = load_script()

    def convert(self, value):
        """Convert a value with the fake Unidecode."""
        return self.module.ascii_name(value, fake_unidecode)

    def run_main(self, argv, modules):
        """Run main() and return its status, standard output and error output."""
        out = io.StringIO()
        err = io.StringIO()
        with mock.patch.dict(sys.modules, modules):
            with mock.patch.object(sys, "argv", argv):
                with contextlib.redirect_stdout(out):
                    with contextlib.redirect_stderr(err):
                        status = self.module.main()
        return status, out.getvalue(), err.getvalue()

    def test_accents_are_removed(self):
        """Accented Latin letters lose their accents."""
        self.assertEqual(self.convert("Ákos Kovács Őrs"), "Akos Kovacs Ors")

    def test_letters_without_decomposition(self):
        """Letters that are no base letter plus accent have their own table."""
        self.assertEqual(self.convert("Straße Ærø Łódź"), "Strasse Aero Lodz")

    def test_cyrillic(self):
        """Cyrillic letters are transliterated with the built-in table."""
        self.assertEqual(self.convert("Щербаков"), "Shcherbakov")
        self.assertEqual(self.convert("Тигрис"), "Tigris")

    def test_greek(self):
        """Greek letters are transliterated and omicron plus upsilon is ou."""
        self.assertEqual(self.convert("Παπαδόπουλος"), "Papadopoulos")
        self.assertEqual(self.convert("Αλέξανδρος"), "Alexandros")

    def test_other_scripts_use_unidecode(self):
        """Every other character is handed to Unidecode one by one."""
        self.assertEqual(self.convert("北京"), "[北][京]")

    def test_plain_ascii_is_unchanged(self):
        """Plain ASCII passes through, including spaces and apostrophes."""
        self.assertEqual(self.convert("O'Neil Mary-Ann"), "O'Neil Mary-Ann")

    def test_main_prints_the_ascii_name(self):
        """The command line takes a JSON string and prints the ASCII name."""
        modules = {"unidecode": mock.Mock(unidecode=fake_unidecode)}
        argv = ["ascii_name.py", json.dumps("Kovács")]
        status, out, _ = self.run_main(argv, modules)
        self.assertEqual(status, 0)
        self.assertEqual(out, "Kovacs")

    def test_main_needs_unidecode(self):
        """Without the Unidecode package the script says so and stops."""
        argv = ["ascii_name.py", json.dumps("Kovács")]
        status, _, err = self.run_main(argv, {"unidecode": None})
        self.assertEqual(status, 2)
        self.assertIn("Unidecode is required", err)

    def test_main_usage(self):
        """Without the JSON argument the script prints the usage."""
        modules = {"unidecode": mock.Mock(unidecode=fake_unidecode)}
        status, _, err = self.run_main(["ascii_name.py"], modules)
        self.assertEqual(status, 1)
        self.assertIn("Usage", err)


if __name__ == "__main__":
    unittest.main()
