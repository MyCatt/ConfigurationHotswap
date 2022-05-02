# This is a sample Python script.

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.


def break_down(file):
    f = open(file)
    component_section = False
    last_line_blank = False
    is_component = True
    for line in f:
        line = line.strip()
        if component_section:
            if last_line_blank and len(line) > 1:
                print(line)
                is_component = True
            elif is_component:
                if len(line) <= 1:
                    is_component = False
                    continue
                print(" "*4, line)
            elif len(line) <= 1:
                print("\n")
                is_component = False

            if len(line) <= 1:
                last_line_blank = True
            else:
                last_line_blank = False
        elif '*** Keywords ***' in line:
            last_line_blank = True
            component_section = True


# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    break_down('example.robot')

# See PyCharm help at https://www.jetbrains.com/help/pycharm/
