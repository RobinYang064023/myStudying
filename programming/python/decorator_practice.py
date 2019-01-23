import sys

def print_paragraph(paragraph):
    print(paragraph)
    return paragraph

def add_bold(paragraph):
    return "<b>" + paragraph() + "</b>"

@ print_paragraph
@ add_bold
def my_paragraph():
    return "test my decorator"

print("====debug====")
print(my_paragraph)
print(add_bold)
#print(add_bold(my_paragraph))
#print(print_paragraph(add_bold))
try:
    print(add_bold(my_paragraph))
except:
    pass
print(print_paragraph)
try:
    print(print_paragraph(add_bold))
except:
    pass

print("====reproduce by normal code====")
def my_paragraph():
    return "test my decorator(reproduce)"
def add_bold(paragraph):
    return "<b>" + paragraph + "</b>"
my_paragraph_ = my_paragraph()
add_bold_ = add_bold(my_paragraph_)
print_paragraph(add_bold_)

print("====reproduce by another decorator====")
def print_paragraph(paragraph_):
    def print_paragraph_(paragraph_):
        print("inner function")
        print(paragraph_())
        print("^^Why no add bold???^^")
        print("--------")
    print("not inner function")
    print("--------")
    print(paragraph_())
    return print_paragraph_

@print_paragraph
def add_bold(paragraph=my_paragraph):
    return "<b>" + paragraph() + "</b>"

@ add_bold
def my_paragraph():
    return "test my decorator"
