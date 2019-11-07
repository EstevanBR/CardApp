import pytest
from report.report import Report


@pytest.fixture
def report() -> Report:
    return Report()


@pytest.fixture
def report_tests(report: Report) -> None:
    yield None
    report.finalize()
    assert report.passed() is True
