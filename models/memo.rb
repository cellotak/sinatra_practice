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
    data = load_data_structure

    new_id = data['last_id'] + 1
    data['last_id'] = new_id

    new_memo = {
      'id' => new_id,
      'title' => title,
      'content' => content,
      'created_at' => Time.now.iso8601
    }

    data['memos'][new_id.to_s] = new_memo

    save_data_structure(data)

    new_memo
  end

  def self.update(id:, title:, content:)
    data = load_data_structure
    target_id_str = id.to_s
    target_memo = data['memos'][target_id_str]

    return nil unless target_memo

    target_memo['title'] = title
    target_memo['content'] = content

    save_data_structure(data)

    target_memo
  end

  def self.destroy(id:)
    data = load_data_structure
    data['memos'].delete(id.to_s)
    save_data_structure(data)
  end

  def self.load_memos
    load_data_structure['memos']
  end

  def self.load_data_structure
    return { 'last_id' => 0, 'memos' => {} } unless File.exist?(MEMO_FILE_PATH)

    begin
      JSON.parse(File.read(MEMO_FILE_PATH))
    rescue JSON::ParserError
      { 'last_id' => 0, 'memos' => {} }
    end
  end

  def self.save_data_structure(data)
    File.open(MEMO_FILE_PATH, 'w') do |file|
      file.write(JSON.pretty_generate(data))
    end
  end

  private_class_method :load_memos, :load_data_structure, :save_data_structure
end
