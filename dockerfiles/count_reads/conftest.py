# conftest.py

import pytest
import os

@pytest.fixture
def test_data_path():
    return os.path.join(os.path.dirname(os.path.abspath(__file__)), "test_data")
