import pyperclip
from sympy import *
init_printing()

x,y,z = symbols('x, y, z')

def texcpy():
    pyperclip.copy(latex(_))
