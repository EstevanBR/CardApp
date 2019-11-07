pytest_plugins = [
    "fixtures.desired_capabilities",
    "fixtures.driver",
    "fixtures.mock",
    "fixtures.page",
    "fixtures.report",
    "fixtures.video"
]


def pytest_addoption(parser):
    parser.addoption("--mock", dest="mock", action="store_true")
