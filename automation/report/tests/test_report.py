import pytest

from report.report import Report


@pytest.fixture(scope="function", autouse=True)
def report():
    return Report()


@pytest.fixture(scope="function", autouse=True)
def report_tests(report: Report) -> None:
    yield None
    report.finalize()
    assert report.passed() is True


class TestReport:
    def test_successes(self, report: Report):
        report.soft_assert(True is True, "KEY-0001", "True is True")

        assert len(report.successes) == 1

    def test_passed(self, report: Report):
        report.soft_assert(True is True, "KEY-0002", "True is True")

        assert report.passed()

    @pytest.mark.xfail(reason="True is not False")
    def test_failures(self, report: Report):
        report.soft_assert(True is False, "KEY-0003", "True should be false")

        assert len(report.failures) == 1

    @pytest.mark.xfail(reason="True is not False")
    def test_errors(self, report: Report):
        report.soft_assert(True is False, "KEY-0004", "True should be false")

        assert len(report.errors) == 1

    @pytest.mark.xfail(reason="True is really actually not False")
    def test_all(self, report: Report):
        report.soft_assert(True is True, "KEY-0001", "True is True")
        report.soft_assert(True is True, "KEY-0002", "True is True")
        report.soft_assert(True is False, "KEY-0003", "True should be false")
        report.soft_assert(True is False, "KEY-0004", "True should be false")
