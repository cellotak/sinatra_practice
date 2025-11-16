# frozen_string_literal: true

require 'json'
require 'time'

class Memo
  MEMO_FILE_PATH = 'data/memo.json'

  def self.all
    load_memos.values
  end

  def self.find(id)
    load_memos[id.to_s]
  end

  def self.create(title:, content:)
    data = load_data

    data['last_id'] = id = data['last_id'] + 1

    new_memo = {
      'id' => id,
      'title' => title,
      'content' => content
    }

    data['memos'][id.to_s] = new_memo
    save_data(data)

    new_memo
  end

  def self.update(id, title:, content:)
    data = load_data
    target_memo = data['memos'][id.to_s]

    return nil unless target_memo

    target_memo['title'] = title
    target_memo['content'] = content

    save_data(data)

    target_memo
  end

  def self.destroy(id)
    data = load_data
    data['memos'].delete(id.to_s)
    save_data(data)
  end

  def self.load_memos
    load_data['memos']
  end

  def self.load_data
    return { 'last_id' => 0, 'memos' => {} } unless File.exist?(MEMO_FILE_PATH)

    JSON.parse(File.read(MEMO_FILE_PATH))
  end

  def self.save_data(data)
    File.open(MEMO_FILE_PATH, 'w') do |file|
      file.write(JSON.pretty_generate(data))
    end
  end

  private_class_method :load_memos, :load_data, :save_data
end
