class Vector:
    def __init__(self, *components):
        self.components = [*components]

    def __iter__(self):
        return self.components.__iter__()

    def map(self, f):
        return Vector(*map(f, self.components))

    def __repr__(self):
        return "Vector" + repr(self.components)

    def __str__(self):
        return "Vector" + str(self.components)

    def __eq__(self, other):
        for (a, b) in zip(self.components, other.components):
            if a != b:
                return False
        return True

    def __call__(self, **kwargs):
        return self.map(lambda c: c(**kwargs))

    def norm(self):
        return sqrt(sum(map(lambda c: c ^ 2, self.components)))

    def substitute(self, *args, **kwargs):
        return self.map(lambda c: c.substitute(*args, **kwargs))

    def solve_eq(self, other, *vars):
        return solve(
            [*map(lambda z: z[0] == z[1], zip(self.components, other.components))],
            *vars
        )

    def integrate(self, at=None, eq=None, wrt=x):
        if at is not None and eq is not None:
            return Vector(*map(lambda z: integrate(z[0], at=at, eq=z[1], wrt=wrt), zip(self, eq)))
        else:
            return self.map(lambda f: integrate(f, at=at, eq=eq, wrt=wrt))

    def diff(self, wrt=x):
        return self.map(lambda f: diff(f, wrt=wrt))
