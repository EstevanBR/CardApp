from test_report.test_report import TestReport
import pytest


@pytest.fixture(scope="function", autouse=True)
def test_report():
    return TestReport()


@pytest.fixture(scope="function", autouse=True)
def report_tests(test_report: TestReport) -> None:
    yield None
    test_report.finalize()
    assert test_report.passed() is True


class TestTestReport:
    def test_successes(self, test_report: TestReport):
        test_report.soft_assert(True is True, "KEY-0001", "True is True")

        assert len(test_report.successes) == 1

    def test_passed(self, test_report: TestReport):
        test_report.soft_assert(True is True, "KEY-0002", "True is True")

        assert test_report.passed()

    @pytest.mark.xfail(reason="True is not False")
    def test_failures(self, test_report: TestReport):
        test_report.soft_assert(True is False, "KEY-0003", "True should be false")

        assert len(test_report.failures) == 1

    @pytest.mark.xfail(reason="True is not False")
    def test_errors(self, test_report):
        test_report.soft_assert(True is False, "KEY-0004", "True should be false")

        assert len(test_report.errors) == 1

    @pytest.mark.xfail(reason="True is really actually not False")
    def test_all(self, test_report):
        test_report.soft_assert(True is True, "KEY-0001", "True is True")
        test_report.soft_assert(True is True, "KEY-0002", "True is True")
        test_report.soft_assert(True is False, "KEY-0003", "True should be false")
        test_report.soft_assert(True is False, "KEY-0004", "True should be false")
