# This is a sample Python script.

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.
import os
import re
import shutil


def break_down(file):
    f = open(os.getcwd() + "\\keyword_input" + "\\" + file)
    component_section = False
    last_line_blank = False
    is_component = True
    line_number = 0
    component_name = None
    for line in f:
        line = line.strip()
        if component_section:
            if last_line_blank and len(line) > 1:
                #print(line)
                component_name = line
                is_component = True
            elif is_component:
                if len(line) <= 1:
                    is_component = False
                    #continue
                line = replace_text_re(line, 'Website Interaction From Configuration.*', component_name)
                # replace_line(file, line_number, "    "+line)
                #print(" "*3, line)
            elif len(line) <= 1:
                #print("\n")
                is_component = False

            if len(line) <= 1:
                last_line_blank = True
            else:
                last_line_blank = False

        elif '*** Keywords ***' in line:
            last_line_blank = True
            component_section = True

        out_file = open(os.getcwd() + "\\keywords_output\\" + file, 'a')
        if (component_name is not None and component_name != line and len(line) > 1):
            print('    ' + line)
            out_file.write('    ' + line+"\n")
        else:
            print(line)
            out_file.write(line+"\n")

# get substring after a string
def get_after(string, after):
    return string[string.find(after) + len(after):]

def replace_text_re(line, regex, replace):
    if re.search(regex, line):
        old_name = get_after(line, 'Website Interaction From Configuration    ')
        #print(old_name+':'+replace)
        out_file = open(os.getcwd() + '\\mapper.txt', 'a')
        out_file.write(old_name+':'+replace + "\n")
        return re.sub(regex, 'Website Interaction Preview    '+replace, line)
    return line

# replace line in file with another line
def replace_line(file, line_number, text):
    lines = open(file, 'r').readlines()
    lines[line_number] = text
    out = open(file, 'w')
    out.writelines(lines)
    out.close()

# replace the text with another text in string
def replace_text(string, old_text, new_text):
    if old_text in string:
        return string.replace(old_text, 'Website Interaction Preview    ' + new_text)
    return string

# replace occurance of text in file
def replace_text_file(file, old_text, new_text):
    f = open(file)
    out = open(file, 'w')
    for line in f:
        out.write(replace_text(line, old_text, new_text))
    f.close()
    out.close()

# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    shutil.rmtree(os.getcwd() + "\\keywords_output", ignore_errors=True)
    os.makedirs(os.getcwd() + "\\keywords_output")
    pages = os.listdir(os.getcwd() + "\\keyword_input")
    for page in pages:
        break_down(page)

