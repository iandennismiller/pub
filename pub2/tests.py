# -*- coding: utf-8 -*-
# Pub2 (c) 2016 Ian Dennis Miller

import tempfile
import os
from shutil import rmtree
from nose.plugins.attrib import attr
from unittest import TestCase
from pub2 import Pub2
from file import File


class Pub2TestSuite(TestCase):
    def setUp(self):
        # self.working_dir = os.path.join(tempfile.gettempdir(), "pub2")
        self.working_dir = os.path.join("/tmp", "pub2")
        print("testing in {0}".format(self.working_dir))

    # def tearDown(self):
    #     try:
    #         rmtree("/tmp/pub2")
    #     except OSError:
    #         pass

    def test_init_folders(self):
        p = Pub2(self.working_dir)
        self.assertIsNotNone(p)
        p.init_folders()

        # this will not be in a git directory...
        self.assertIsNone(p.get_checksum())

    def test_finding(self):
        p = Pub2(self.working_dir)
        p.init_folders()

        file_list = p.find_files()
        self.assertGreater(len(file_list), 0)

        changed_files = p.detect_changed_files()
        self.assertGreater(len(changed_files), 0)

    def test_json_digest(self):
        p = Pub2(self.working_dir)
        p.init_folders()
        p.create_json_digest()
        self.assertTrue(os.path.isfile(os.path.join(self.working_dir, "_data", "pub2.json")))

    def test_template(self):
        p = Pub2(self.working_dir)
        p.init_folders()
        p.create_from_template(author="Ian", title="Meme Pounder", year=2017)
        self.assertTrue(os.path.isfile(os.path.join(self.working_dir, "_pubs", "meme-pounder.tex")))

    # @attr("slow")
    def test_build(self):
        p = Pub2(self.working_dir)
        p.init_folders()
        p.build()


class FileTestSuite(TestCase):
    def setUp(self):
        # self.working_dir = os.path.join(tempfile.gettempdir(), "pub2")
        self.working_dir = os.path.join("/tmp", "pub2")
        print("testing in {0}".format(self.working_dir))

    # def tearDown(self):
    #     try:
    #         rmtree("/tmp/pub2")
    #     except OSError:
    #         pass

    def testFileLoad(self):
        p = Pub2(self.working_dir)
        p.init_folders()

        file_list = p.find_files()
        first_file = file_list[0]

        f = p.load_file(first_file)
        self.assertIsNotNone(f)
        return(f)

    def testPreamble(self):
        f = self.testFileLoad()
        self.assertIsNotNone(f.get_preamble())
        self.assertIsNotNone(f.get_content())
        self.assertIsNotNone(f.get_identifier())
