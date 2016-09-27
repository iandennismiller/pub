#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Pub2 (cc) 2016 Ian Dennis Miller

import yaml
import os
import re
import shutil
import codecs
from jinja2 import Template
from distutils.dir_util import copy_tree


class File():
    def __init__(self, pub2_obj, filename):
        self.pub2_obj = pub2_obj
        self.filename = filename
        self.working_dir = self.pub2_obj.working_dir
        self.raw = None

        with codecs.open(filename, "r", "utf-8") as f:
            self.raw = f.read()

        self.preamble = self.get_preamble()
        self.content = self.get_content()
        self.identifier = self.get_identifier()
        self.checksum = self.pub2_obj.get_checksum()
        self.preamble['checksum'] = self.checksum

    def get_language(self):
        """
        normalize the filename extension into a language symbol.
        """
        base_filename, file_extension = os.path.splitext(self.filename)
        mapping = {
            "md": "markdown",
            "markdown": "markdown",
            "tex": "latex",
        }
        if file_extension in mapping:
            return(mapping[file_extension])

    def get_preamble(self):
        """
        extract portion of file between ---.
        decode it as YAML and return a python object.
        """
        re_preamble = r"---\n(.*?)---\n"
        m = re.match(re_preamble, self.raw, re.MULTILINE | re.DOTALL)
        if m:
            preamble = m.group(1)
            return(yaml.load(preamble))
        else:
            print("cannot find preamble")

    def get_content(self):
        """
        return everything appearing after the preamble
        """
        re_content = r"^---$.*?^---$(.*)"
        m = re.search(re_content, self.raw, re.MULTILINE | re.DOTALL)
        if m:
            content = m.group(1)
            return(unicode(content))

    def get_rendered_content(self):
        """
        """
        # env = Environment(loader=PackageLoader('pub', '_layouts'))

        if 'layout' in self.preamble and self.preamble['layout'] != None:
            layout_filename = "_pubs/_layouts/{0}.tex".format(self.preamble['layout'])
            with codecs.open(layout_filename, "r", "utf-8") as f:
                re_content = r"^---$.*?^---$(.*)"
                m = re.search(re_content, f.read(), re.MULTILINE | re.DOTALL)
                if m:
                    layout_template = Template(m.group(1))
            result = layout_template.render(pub=self.preamble, content=self.content)
            # result = layout_template.render(pub=self.preamble, content="")
            return(result)
        else:
            return(self.content)

    def get_identifier(self):
        """
        return a hardcoded identifier - otherwise, format default
        """
        if 'identifier' in self.preamble:
            return(self.preamble['identifier'])
        else:
            self.preamble['author_last'] = self.preamble['author'].split(" ")[0]
            self.preamble['title_first'] = self.preamble['title'].split(" ")[0]
            return("{author_last}_{title_first}_{year}").format(self.preamble)

    def create_bibtex(self):
        """
        create the bibtex file for this pub
        """
        # determine filename
        filename = "./pub/{0}.bib".format(self.identifier)

        with codecs.open("_pubs/_templates/citation.bib", "r", "utf-8") as f:
            bibtex_template = f.read()

        bibtex_str = bibtex_template.format(**self.preamble)
        with codecs.open(filename, "w", "utf-8") as f:
            f.write(bibtex_str)

    def create_html(self):
        """
        create the bibtex file for this pub
        """
        # determine filename
        filename = "./pub/{0}.html".format(self.identifier)

        with codecs.open("_pubs/_templates/view.html", "r", "utf-8") as f:
            html_template = f.read()

        html_str = html_template.format(**self.preamble)
        with codecs.open(filename, "w", "utf-8") as f:
            f.write(html_str)

    def create_pdf(self):
        """
        create the PDF file for this pub
        """
        # ensure .build directory exists
        if not os.path.exists(".build"):
            os.makedirs(".build")

        with codecs.open(".build/pub2.tex", "w", "utf-8") as f:
            tmp_content = self.get_rendered_content()
            f.write(tmp_content)

        basename = os.path.basename(self.filename)[:-4]

        # copy assets
        assets_path = "_pubs/_assets/{0}/".format(basename)
        if os.path.exists(assets_path):
            copy_tree(assets_path, ".build/")
        else:
            print("no assets for {0}".format(basename))

        latex_cmd = 'cd .build && pdflatex pub2.tex'
        bibtex_cmd = 'cd .build && bibtex pub2.aux'
        biber_cmd = 'cd .build && biber pub2'

        # run latex
        os.system(latex_cmd)

        # if bibliography
        if "bibtex" in self.preamble and self.preamble["bibtex"] == True:
            os.system(bibtex_cmd)
            os.system(latex_cmd)
        elif "biber" in self.preamble and self.preamble["biber"] == True:
            os.system(biber_cmd)
            os.system(latex_cmd)

        os.system(latex_cmd)

        # copy result PDF
        shutil.copy2(".build/pub2.pdf", "pub/{0}.pdf".format(self.preamble["identifier"]))
        shutil.rmtree(".build")

    def is_stale(self):
        """
        return True if the files in pub are older than the one in _pubs.
        """
        bib_filename = "pub/{0}.bib".format(self.identifier)
        pdf_filename = "pub/{0}.pdf".format(self.identifier)
        html_filename = "pub/{0}.html".format(self.identifier)

        if not os.path.isfile("_data/pub2.json"):
            return True

        # if a file does not exist, return True
        if not os.path.isfile(html_filename):
            return True

        if not os.path.isfile(bib_filename):
            return True

        if not os.path.isfile(pdf_filename):
            return True

        # if the modification time of the .bib or .pdf is older, return True
        (mode, ino, dev, nlink, uid, gid, size, atime, mtime, ctime) = os.stat(self.filename)
        source_mtime = mtime

        (mode, ino, dev, nlink, uid, gid, size, atime, mtime, ctime) = os.stat(bib_filename)
        bib_mtime = mtime

        (mode, ino, dev, nlink, uid, gid, size, atime, mtime, ctime) = os.stat(pdf_filename)
        pdf_mtime = mtime

        (mode, ino, dev, nlink, uid, gid, size, atime, mtime, ctime) = os.stat(html_filename)
        html_mtime = mtime

        if source_mtime > bib_mtime or source_mtime > pdf_mtime or source_mtime > html_mtime:
            return True
