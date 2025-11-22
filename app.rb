# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'erb'
require_relative 'models/memo'

helpers do
  include ERB::Util
end

get '/' do
  redirect '/memos'
end

get '/memos' do
  @memos = Memo.all
  erb :index
end

post '/memos' do
  new_memo = Memo.create(title: params[:title], content: params[:content])
  redirect "/memos/#{new_memo['id']}"
end

get '/memos/new' do
  erb :new
end

get '/memos/:id' do
  @memo = Memo.find(params[:id])
  halt 404 unless @memo
  erb :show
end

patch '/memos/:id' do
  memo = Memo.update(params[:id], title: params[:title], content: params[:content])
  halt 404 unless memo
  redirect "/memos/#{params[:id]}"
end

delete '/memos/:id' do
  Memo.destroy(params[:id])
  redirect '/memos'
end

get '/memos/:id/edit' do
  @memo = Memo.find(params[:id])
  halt 404 unless @memo
  erb :edit
end

not_found do
  erb :not_found
end
