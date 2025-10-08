# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../app'

class TestSaveMemos < Minitest::Test
  def setup
    @test_file_path = 'test_memo.json'
  end

  def teardown
    File.delete(@test_file_path) if File.exist?(@test_file_path)
  end

  def test_load_memos_with_existing_file
    memos = [
      { 'id' => 1, 'title' => 'Existing Memo', 'content' => 'Content' }
    ]
    File.write(@test_file_path, JSON.pretty_generate(memos))

    loaded_memos = load_memos(@test_file_path)

    assert_equal memos, loaded_memos
  end

  def test_save_memos
    memos_data = [
      { 'id' => 1, 'title' => 'Test title', 'content' => 'Test content' }
    ]
    save_memos(memos_data, @test_file_path)
    assert File.exist?(@test_file_path)
    assert_equal JSON.pretty_generate(memos_data), File.read(@test_file_path)
  end
end
