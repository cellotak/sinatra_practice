# frozen_string_literal: true

require 'pg'
require 'dotenv/load'

class Memo
  def self.connection
    @connection ||= PG::Connection.new(ENV.fetch('DATABASE_URL'))
  end

  def self.all
    connection.exec(<<~SQL).to_a
      SELECT id, title, content
      FROM memos
      ORDER BY id DESC
    SQL
  end

  def self.find(id)
    result = connection.exec_params(<<~SQL, [id.to_i])
      SELECT id, title, content
      FROM memos
      WHERE id = $1
    SQL
    result[0] if result.any?
  end

  def self.create(title:, content:)
    connection.exec_params(<<~SQL, [title, content])[0]
      INSERT INTO memos (title, content)
      VALUES ($1, $2)
      RETURNING id, title, content
    SQL
  end

  def self.update(id, title:, content:)
    result = connection.exec_params(<<~SQL, [title, content, id.to_i])
      UPDATE memos
      SET title = $1, content = $2
      WHERE id = $3
      RETURNING id, title, content
    SQL
    result[0] if result.any?
  end

  def self.destroy(id)
    connection.exec_params(<<~SQL, [id.to_i])
      DELETE FROM memos
      WHERE id = $1
    SQL
  end
end
