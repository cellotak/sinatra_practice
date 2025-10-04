# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

def load_memos
  file_path = 'data/memo.json'
  if File.exist?(file_path)
    JSON.parse(File.read(file_path))
  else
    []
  end
end

get '/' do
  redirect '/memos'
end

get '/memos' do
  @memos = load_memos
  erb :index
end
