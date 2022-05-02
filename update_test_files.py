# This is a sample Python script.

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.
import os
import re
import shutil


def replace_text(string, old_text, new_text):
    if old_text in string:
        return string.replace('    '+old_text+'    ', '    '+new_text+'    ')
    return string

# replace occurance of text in file
def replace_text_file(file, old_text, new_text):
    print(file)
    f = open(os.getcwd() + "\\tests\\"+file)
    i = 0
    shutil.rmtree(os.getcwd() + "\\tests_new", ignore_errors=True)
    os.makedirs(os.getcwd() +  "\\tests_new")
    out = open(os.getcwd() + "\\tests_new\\"+file, 'a')
    for line in f:
        i = i + 1
        #print(i)
        line = line.rstrip('\n')
        #print(line)
        out.write(replace_text(line, old_text, new_text)+"\n")
    f.close()
    out.close()
    shutil.copy(os.getcwd() + "\\tests_new\\"+file, os.getcwd() + "\\tests\\"+file)

def get_mapper(file, testsDir):
    pages = os.listdir(testsDir)
    f_map = open(file)
    for line in f_map:
        line = line.strip()
        if  len(line) <= 1:
            continue
        map = line.split(':')
        for page in pages:
            #print(page)
            replace_text_file(page, map[0], map[1])

# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    get_mapper('mapper.txt', os.getcwd() + "\\tests")

