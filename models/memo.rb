# frozen_string_literal: true

require 'json'
require 'time'

class Memo
  MEMO_FILE_PATH = 'data/memo.json'

  def self.all
    load_data['memos'].values
  end

  def self.find(id)
    load_data['memos'][id.to_s]
  end

  def self.create(title:, content:)
    data = load_data

    data['last_id'] = id = data['last_id'] + 1

    memo = {
      'id' => id,
      'title' => title,
      'content' => content
    }

    data['memos'][id.to_s] = memo
    save_data(data)

    memo
  end

  def self.update(id, title:, content:)
    data = load_data
    memo = data['memos'][id.to_s]

    return nil unless memo

    memo['title'] = title
    memo['content'] = content

    save_data(data)

    memo
  end

  def self.destroy(id)
    data = load_data
    data['memos'].delete(id.to_s)
    save_data(data)
  end

  def self.load_data
    File.exist?(MEMO_FILE_PATH) ? JSON.parse(File.read(MEMO_FILE_PATH)) : { 'last_id' => 0, 'memos' => {} }
  end

  def self.save_data(data)
    File.open(MEMO_FILE_PATH, 'w') do |file|
      file.write(JSON.pretty_generate(data))
    end
  end

  private_class_method :load_data, :save_data
end
