require 'test/unit'

FIXTURES = '/fixtures'

class TestLightOpencvWrapper < Test::Unit::TestCase
  def test_module_installed
    assert_nothing_raised do
      require 'light_opencv'
    end
  end
end
