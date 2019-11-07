import pytest
import logging

"""
Default desired_capabilities fixtures
"""
@pytest.fixture(scope="session", autouse=False)
def bundleId() -> str:
    return "com.toiletsnakes.Card"


@pytest.fixture(scope="session", autouse=False)
def app() -> str:
    return "/Users/ehernandez/Desktop/Build/Products/Debug-iphonesimulator/Card.app/"


@pytest.fixture(scope="session", autouse=False)
def deviceName() -> str:
    return "iPhone 8"


@pytest.fixture(scope="session", autouse=False)
def udid() -> str:
    return "E66E2326-AEE4-482A-9B40-4C6C6F75563C"


@pytest.fixture(scope="session", autouse=False)
def platformVersion() -> str:
    return "13"


@pytest.fixture(scope="session", autouse=False)
def platformName() -> str:
    return "iOS"


@pytest.fixture(scope="session", autouse=False)
def derivedDataPath() -> str:
    return "/Users/ehernandez/Library/Developer/Xcode/DerivedData/WebDriverAgent-ciegwgvxzxdrqthilmrmczmqvrgu"


@pytest.fixture(scope="session", autouse=False)
def noReset() -> bool:
    return True


@pytest.fixture(scope="session", autouse=False)
def fullReset() -> bool:
    return False


@pytest.fixture(scope="session", autouse=False)
def desired_capabilities(
    bundleId: str,
    app: str,
    deviceName: str,
    udid: str,
    platformVersion: str,
    platformName: str,
    noReset: bool,
    fullReset: bool,
    derivedDataPath: str
) -> dict:
    desired_capabilities = {
        "bundleId": bundleId,
        "app": app,
        "deviceName": deviceName,
        "udid": udid,
        "platformVersion": platformVersion,
        "platformName": platformName,
        "noReset": noReset,
        "fullReset": fullReset,
        "newCommandTimeout": 60,
        "autoLaunch": False,
        "autoAcceptAlerts": True,
        "derivedDataPath": derivedDataPath,
        "processArguments": {
            "args": [
                "RESET"
            ],
            "env": {

            }
        }
    }
    logging.debug(f"desired_capabilities\n{desired_capabilities}")
    return desired_capabilities
