# frozen_string_literal: true

require 'pg'
require 'dotenv/load'

class Memo
  def self.connection
    @connection ||= PG::Connection.new(ENV.fetch('DATABASE_URL'))
  end

  def self.all
    connection.exec('SELECT id, title, content FROM memos ORDER BY id DESC').to_a
  end

  def self.find(id)
    result = connection.exec_params('SELECT id, title, content FROM memos WHERE id = $1', [id.to_i])
    result[0] if result.any?
  end

  def self.create(title:, content:)
    connection.exec_params('INSERT INTO memos (title, content) VALUES ($1, $2) RETURNING id, title, content', [title, content])[0]
  end

  def self.update(id, title:, content:)
    result = connection.exec_params('UPDATE memos SET title = $1, content = $2 WHERE id = $3 RETURNING id, title, content', [title, content, id.to_i])
    result[0] if result.any?
  end

  def self.destroy(id)
    connection.exec_params('DELETE FROM memos WHERE id = $1', [id.to_i])
  end
end
