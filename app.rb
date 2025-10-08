# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

MEMO_FILE_PATH = 'data/memo.json'

def load_memos(file_path)
  if File.exist?(file_path)
    JSON.parse(File.read(file_path))
  else
    []
  end
end

def save_memos(memos, file_path)
  File.open(file_path, 'w') do |file|
    file.write(JSON.pretty_generate(memos))
  end
end

get '/' do
  redirect '/memos'
end

get '/memos' do
  @memos = load_memos(MEMO_FILE_PATH)
  erb :index
end

get '/memos/new' do
  erb :new
end

get '/memos/:id' do
  @memos = load_memos(MEMO_FILE_PATH)
  @memo = @memos.find { |memo| memo['id'] == params[:id].to_i }
  erb :show
end

get '/memos/:id/edit' do
  @memos = load_memos(MEMO_FILE_PATH)
  @memo = @memos.find { |memo| memo['id'] == params[:id].to_i }
  erb :edit
end
