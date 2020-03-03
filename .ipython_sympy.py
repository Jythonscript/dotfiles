import pyperclip
from sympy import *
init_printing()

# symbols
x, y, z = symbols('x y z')
a, b, c = symbols('a b c')
k, m, n = symbols('k m n', integer=True)
f, g, h = symbols('f g h', cls=Function)
t = symbols('t')
phi,rho,theta = symbols('phi, rho, theta')

def texcpy():
    pyperclip.copy(latex(_))
