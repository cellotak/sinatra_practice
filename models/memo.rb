# frozen_string_literal: true

require 'json'
require 'time'

class Memo
  MEMO_FILE_PATH = 'data/memo.json'

  def self.all
    load_memos.values
  end

  def self.find(id)
    load_memos[id.to_i]
  end

  def self.create(title:, content:)
    memos = load_memos
    new_id = (memos.keys.max || 0) + 1
    new_memo = {
      'id' => new_id,
      'title' => title,
      'content' => content,
      'created_at' => Time.now.iso8601
    }
    memos[new_id] = new_memo
    save_memos(memos)

    new_memo
  end

  def self.update(id:, title:, content:)
    memos = load_memos
    target_memo = memos[id.to_i]

    return nil unless target_memo

    target_memo['title'] = title
    target_memo['content'] = content
    save_memos(memos)

    target_memo
  end

  def self.destroy(id:)
    memos = load_memos
    memos.delete(id.to_i)
    save_memos(memos)
  end

  def self.load_memos
    if File.exist?(MEMO_FILE_PATH)
      json_data = JSON.parse(File.read(MEMO_FILE_PATH))
      json_data.map { |memo| [memo['id'], memo] }.to_h
    else
      {}
    end
  end

  def self.save_memos(memos)
    File.open(MEMO_FILE_PATH, 'w') do |file|
      file.write(JSON.pretty_generate(memos.values))
    end
  end

  private_class_method :load_memos, :save_memos
end
