require File.join File.dirname(__FILE__), 'helper'

class HasherTest < Test::Unit::TestCase
  def setup
    string = "Words word a the at fish fishing fishes? /^/  The at a of! @#$!"
    @text_hash = Ankusa::TextHash.new string
    @array = Ankusa::TextHash.new [string]
  end

  def test_stemming
    assert_equal @text_hash.length, 2
    assert_equal @text_hash.word_count, 5

    assert_equal @array.length, 2
    assert_equal @array.word_count, 5
  end

  def test_add_text_valid_ascii
    t = Ankusa::TextHash.new.add_text('valid')
    assert_equal(t[:valid], 1)
    t.add_text('valid2')
    assert_equal(t[:valid], 1)
    assert_equal(t[:valid2], 1)
  end

  def test_add_text_with_invalid_ascii
    t = Ankusa::TextHash.new.add_text('valid')
    assert_equal(t, t.add_text('23456'))
    assert_equal(t, t.add_text('corresponding'))
  end

end
