#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json, os

from os import path

from deepnlpf.core.util import Util
from deepnlpf.core.iplugin import IPlugin
from deepnlpf.core.output_format import OutputFormat

class Plugin(IPlugin):

    def __init__(self, document, pipeline):
        self._document = document

        PATH_BASE = path.abspath(path.dirname(__file__))
        PATH_TEMP = PATH_BASE + "/temp/"
        
        self.PATH_SEMAFOR = PATH_BASE
        self.PATH_SCRIPT = './resources/bin/runSemafor.sh'
        self.PATH_RAW_INPUT = PATH_TEMP + "in-sentences.txt"
        self.PATH_RAW_OUTPUT = PATH_TEMP + "out-sentences.txt"

    def run(self):
        return self.wrapper(self._document)

    def wrapper(self, dataset, threads=4):
        '''
            Execute the SEMAFOR.
            @param theads (inform the number of threads that you want to execute.)
        '''

        # salve all sentences in file input.
        self.raw_input(dataset)

        # check if an output file exists and exclude.
        os.system('cd ' + self.PATH_SEMAFOR +
                ' && [ -e ' + self.PATH_RAW_OUTPUT + ' ] ' + 
                ' && rm ' + self.PATH_RAW_OUTPUT +
                ' && touch '+ self.PATH_RAW_OUTPUT)

        # processes a new file.
        try:
            os.system('cd ' + self.PATH_SEMAFOR + ' && ' + self.PATH_SCRIPT + ' ' +
                self.PATH_RAW_INPUT + ' ' + self.PATH_RAW_OUTPUT + ' ' + str(threads))
        except Exception as err:
            print(err)

        return self.out_format(Util().open_txt(self.PATH_RAW_OUTPUT))

    def raw_input(self, dataset):
        '''
            Saves the sentence that will be processed in a text file.
            @param dataset
        '''
        temp_file = open(self.PATH_RAW_INPUT, 'w')

        for line in dataset:
            temp_file.write(line+"\n")

        temp_file.close()

    def out_format(self, annotation):        
        return OutputFormat().doc_annotation(
            _id_dataset=self._document['_id_dataset'],
            _id_document=self._document['_id'],
            tool="semafor",
            annotation=[json.loads(sent) for sent in annotation]
        )
