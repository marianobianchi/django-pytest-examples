import pytest


@pytest.fixture(scope="module")
def smtp():
    file_ = open('/tmp/testing_example.txt', 'w')
    yield file_
    print("teardown file (limpieza luego de ejecutar)")
    file_.close()
