def integrate(f, at=None, eq=None, wrt=x):
    c = var("c")

    # functional style lets us integrate integers
    F = integral(f, wrt) + c

    if at is not None and eq is not None:
        solutions = solve(F(**{str(wrt): at}) == eq, c)

        if not solutions:
            return F
        elif len(solutions) == 1:
            return F.substitute(solutions[0])
        else:
            print(f"available solutions: {solutions}")
            return F
    else:
        return F


def diff(f, wrt=x):
    return derivative(f, wrt)
